class AddPreviousMovementsToKyc < ActiveRecord::Migration[5.1]
  def change
    add_belongs_to :movements_movements, :kyc
  end
end
