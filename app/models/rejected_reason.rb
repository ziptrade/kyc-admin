class RejectedReason < ApplicationRecord

  validates :name, :description, presence: true
end
