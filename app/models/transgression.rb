class Transgression < ApplicationRecord
  belongs_to :movement, class_name: 'Movements::Movement'
  belongs_to :movement_restriction
  monetize :surpassing_amount_cents
end
