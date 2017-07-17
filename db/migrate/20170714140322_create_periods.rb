class CreatePeriods < ActiveRecord::Migration[5.1]
  def change
    create_table :periods_periods do |t|
      t.integer :times
      t.string :type
      t.timestamps
    end
  end
end
