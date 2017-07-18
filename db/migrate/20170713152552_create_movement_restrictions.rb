class CreateMovementRestrictions < ActiveRecord::Migration[5.1]
  def change
    create_table :movement_restrictions do |t|

      t.timestamps
    end
  end
end
