class CreateKycPrototypes < ActiveRecord::Migration[5.1]
  def change
    create_table :kycs do |t|

      t.timestamps
    end
  end
end
