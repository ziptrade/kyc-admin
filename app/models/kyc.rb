class Kyc < ApplicationRecord
  belongs_to :state
  belongs_to :kyc_change_request, optional: true

  delegate :able_to_make_movements?, to: :state

  def self.create_empty
    self.create!(state: Empty.create!)
  end

  def add_change_request(a_change_request)
    self.kyc_change_request = a_change_request
  end

  def pending_review?
    !kyc_change_request.nil?
  end
end
