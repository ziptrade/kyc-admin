class Kyc < ApplicationRecord
  belongs_to :state, :class_name => 'States::State'

  delegate :usable?, to: :state

  def self.create_empty
    self.create!(state: States::Empty.create!)
  end

  def add_change_request(change_request)
    state.add_change_request(change_request, self)
  end

  def approve
    state.approve(self)
  end
end
