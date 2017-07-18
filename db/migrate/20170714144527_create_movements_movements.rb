class CreateMovementsMovements < ActiveRecord::Migration[5.1]
  def change
    create_table :movements_movements do |t|
      t.monetize :amount
      t.datetime :moment
      t.string :type
      t.timestamps
    end
  end
end
