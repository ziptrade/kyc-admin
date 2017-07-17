require 'rails_helper'
require_relative '../stubs/alarm_caller_stub'

RSpec.describe MovementRestriction, type: :model do
  context 'When having a KYC with no previous movements' do
    let(:kyc) { build(:kyc_with_no_movements) }
    context 'and defining the profiling and approving those changes' do
      let(:currency) { 'USD' }
      let(:money_limit_cents) { 20_000 }

      let(:period) { Periods::Month.new(times: 1) }
      let(:money_limit) { Money.new(money_limit_cents, currency) }
      let(:movement_restriction) { MovementRestriction.new(period: period, money_limit: money_limit) }
      let(:profiling_definition) { Changes::ProfilingDefinition.new(movement_restrictions: [movement_restriction]) }
      before do
        kyc.add_change_request(profiling_definition)
        kyc.approve
      end
      context 'and a deposit surpass the limit established by the profiling' do
        let(:surpassing_amount) { Money.new('100', currency) }
        let(:money_higher_than_limit) { money_limit + surpassing_amount }
        let(:high_deposit) { Movements::Deposit.new(amount: money_higher_than_limit, moment: DateTime.now) }
        let(:alarm_caller) { AlarmCallerStub.new }
        it 'should raise an alarm' do
          expect do
            kyc.register_movement(high_deposit, alarm_caller)
          end.to(change { alarm_caller.amounts_of_alarms_raised }.by(1))
        end

        it 'the alarm raised should be of surpassing the movement limit by the surpassing amount' do
          kyc.register_movement(high_deposit, alarm_caller)
          transgression = alarm_caller.last_transgression
          expect(transgression.movement).to eq(high_deposit)
          expect(transgression.surpassing_amount).to eq(surpassing_amount)
          expect(transgression.movement_restriction).to eq(movement_restriction)
        end
      end
    end
  end
end
