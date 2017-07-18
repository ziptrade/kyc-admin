require 'rails_helper'
require_relative '../stubs/alarm_caller_stub'

RSpec.describe MovementRestriction, type: :model do
  def assert_last_transgression_has(alarm_caller, movement, surpassing_amount, movement_restriction)
    transgression = alarm_caller.last_transgression
    expect(transgression.movement).to eq(movement)
    expect(transgression.surpassing_amount).to eq(surpassing_amount)
    expect(transgression.movement_restriction).to eq(movement_restriction)
  end

  context 'When having a KYC with no previous movements' do
    let(:kyc) { build(:kyc_with_no_movements) }
    context 'and defining the profiling and approving those changes' do
      let(:currency) { 'USD' }
      let(:money_limit_cents) { 20_000 }
      let(:alarm_caller) { AlarmCallerStub.new }

      let(:period) { Periods::Month.new(times: 1) }
      let(:money_limit) { Money.new(money_limit_cents, currency) }
      let(:movement_restriction) { MovementRestriction.new(period: period, money_limit: money_limit) }
      let(:profiling_definition) { Changes::ProfilingDefinition.new(movement_restrictions: [movement_restriction]) }
      before do
        kyc.add_change_request(profiling_definition)
        kyc.approve
      end

      context 'and it registers a movement that does not surpass the limit' do
        let(:under_max_limit_amount) { Money.new('500', currency) }
        let(:money_lower_than_limit) { money_limit - under_max_limit_amount }
        let(:low_movement) { Movements::Deposit.new(amount: money_lower_than_limit, moment: DateTime.now) }

        it 'should not raise an alarm' do
          expect do
            kyc.register_movement(low_movement, alarm_caller)
          end.not_to(change { alarm_caller.amounts_of_alarms_raised })
        end

        context 'and it registers another movement' do
          let(:another_movement) do
            Movements::Withdrawal.new(amount: another_money_amount, moment: moment_inside_period)
          end
          before do
            kyc.register_movement(low_movement, alarm_caller)
          end
          context 'and that movement occurred inside the restriction period' do
            let(:moment_inside_period) { 5.days.after(low_movement.moment) }

            context 'and the addition of those does not surpass the limit' do
              let(:another_money_amount) { money_limit - money_lower_than_limit - Money.new('100', currency) }

              it 'should not raise an alarm' do
                expect do
                  kyc.register_movement(another_movement, alarm_caller)
                end.not_to(change { alarm_caller.amounts_of_alarms_raised })
              end
            end

            context 'and the addition of those surpass the limit' do
              let(:surpassing_amount) { Money.new('100', currency) }
              let(:another_money_amount) { money_limit - money_lower_than_limit + surpassing_amount }
              it 'should raise an alarm' do
                expect do
                  kyc.register_movement(another_movement, alarm_caller)
                end.to(change { alarm_caller.amounts_of_alarms_raised }.by(1))
              end

              it 'the alarm raised should be of surpassing the movement limit by the surpassing amount' do
                kyc.register_movement(another_movement, alarm_caller)
                assert_last_transgression_has(alarm_caller, another_movement,
                                              surpassing_amount, movement_restriction)
              end
            end
          end

          context 'and that movement occurred outside the restriction period' do
            let(:moment_inside_period) { 1.month.after(1.days.after(low_movement.moment)) }
            context 'and the addition of those surpass the limit' do
              let(:surpassing_amount) { Money.new('100', currency) }
              let(:another_money_amount) { money_limit - money_lower_than_limit + surpassing_amount }

              it 'should not raise an alarm' do
                expect do
                  kyc.register_movement(another_movement, alarm_caller)
                end.not_to(change { alarm_caller.amounts_of_alarms_raised })
              end
            end
          end
        end
      end

      context 'and a deposit surpass the limit established by the profiling' do
        let(:surpassing_amount) { Money.new('100', currency) }
        let(:money_higher_than_limit) { money_limit + surpassing_amount }
        let(:high_deposit) { Movements::Deposit.new(amount: money_higher_than_limit, moment: DateTime.now) }

        it 'should raise an alarm' do
          expect do
            kyc.register_movement(high_deposit, alarm_caller)
          end.to(change { alarm_caller.amounts_of_alarms_raised }.by(1))
        end

        it 'the alarm raised should be of surpassing the movement limit by the surpassing amount' do
          kyc.register_movement(high_deposit, alarm_caller)
          assert_last_transgression_has(alarm_caller, high_deposit, surpassing_amount, movement_restriction)
        end
      end
    end
  end
end
