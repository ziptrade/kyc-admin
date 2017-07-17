class MovementRestriction < ApplicationRecord
  belongs_to :profiling_definition, class_name: 'Changes::ProfilingDefinition'
  belongs_to :period, class_name: 'Periods::Period'

  monetize :money_limit_cents

  def notify_on_transgression(movement, kyc, alarm_caller)
    moved_on_period = moved_on_period(kyc, movement)
    notify_transgression(alarm_caller, movement, moved_on_period) if transgressed_by?(moved_on_period)
  end

  private

  def notify_transgression(alarm_caller, movement, moved_on_period)
    transgression = transgression(movement, moved_on_period)
    alarm_caller.notify_transgression(transgression)
  end

  def transgression(movement, moved_on_period)
    surpassing_amount = moved_on_period - money_limit
    Transgression.new(movement: movement, movement_restriction: self, surpassing_amount: surpassing_amount)
  end

  def transgressed_by?(moved_on_period)
    money_limit < moved_on_period
  end

  def moved_on_period(kyc, movement)
    previous_movements = kyc.movements_between(period_start(movement), period_end(movement))
    previous_movements.inject(movement.moved) do |amount, a_movement|
      amount + a_movement.moved
    end
  end

  def period_start(movement)
    period.before(period_end(movement))
  end

  def period_end(movement)
    movement.moment
  end
end
