class CreateKycChangeRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :kyc_change_requests do |t|
      t.string :first_name
      t.string :last_name
      t.string :id_number
      t.string :id_type

      t.timestamps
    end
  end
end
