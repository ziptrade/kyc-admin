class CreateDockets < ActiveRecord::Migration[5.1]
  def change
    create_table :dockets do |t|
      t.string :first_name
      t.string :last_name
      t.string :id_number
      t.string :id_type

      t.timestamps
    end
  end
end
