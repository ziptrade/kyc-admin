class AddMonetizeToMovementRestriction < ActiveRecord::Migration[5.1]
  def change
    add_monetize :movement_restrictions, :money_limit
  end
end
