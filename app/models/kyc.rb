class Kyc < ApplicationRecord
  belongs_to :state, :class_name => 'States::State'

  delegate :usable?, to: :state

  def self.create_empty!
    kyc = self.new_empty
    kyc.save!
    kyc
  end

  def self.new_empty
    self.new(state: States::Empty.create!)
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
end
