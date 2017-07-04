class Kyc < ApplicationRecord
  belongs_to :state
  delegate :able_to_make_movements?, to: :state

  def self.create_empty
    self.create!(state: Empty.create!)
  end
end
