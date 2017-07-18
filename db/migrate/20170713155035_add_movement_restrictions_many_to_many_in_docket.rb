class AddMovementRestrictionsManyToManyInDocket < ActiveRecord::Migration[5.1]
  def change
    create_table :dockets_movement_restrictions do |t|
      t.belongs_to :docket
      t.belongs_to :movement_restriction
    end
  end
end
