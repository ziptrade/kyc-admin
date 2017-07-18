class AddPeriodToMovementRestriction < ActiveRecord::Migration[5.1]
  def change
    add_belongs_to :movement_restrictions, :period, class_name: 'Periods::Period'
  end
end
