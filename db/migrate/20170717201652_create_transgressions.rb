class CreateTransgressions < ActiveRecord::Migration[5.1]
  def change
    create_table :transgressions do |t|
      t.belongs_to :movement, class_name: 'Movements::Movement'
      t.belongs_to :movement_restriction
      t.monetize :surpassing_amount
      t.timestamps
    end
  end
end
