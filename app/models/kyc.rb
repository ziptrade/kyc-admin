class Kyc < ApplicationRecord
  belongs_to :state, class_name: 'States::State'
  has_many :previous_movements, class_name: 'Movements::Movement'

  delegate :usable?, to: :state
  delegate :docket, to: :state
  delegate :movement_restrictions, to: :docket

  def self.create_empty!
    kyc = new_empty
    kyc.save!
    kyc
  end

  def self.new_empty
    new(state: States::Empty.create!)
  end

  def add_change_request(change_request)
    state.add_change_request(change_request, self)
  end

  def approve
    state.approve(self)
  end

  def reject_changes(reasons)
    state.reject_changes(self, reasons)
  end

  def blacklist(reason)
    state.blacklist(self, reason)
  end

  def remove_from_blacklist
    state.remove_from_blacklist(self)
  end

  def change_to_state(new_state)
    self.state = new_state
  end

  def register_movement(movement, alarm_caller)
    state.register_movement(movement, self, alarm_caller)
    previous_movements.push(movement)
  end

  def movements_between(period_end, period_start)
    previous_movements.where(moment: period_start..period_end)
  end
end
