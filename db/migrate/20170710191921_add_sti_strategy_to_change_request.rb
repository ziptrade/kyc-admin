class AddStiStrategyToChangeRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :changes_kyc_change_requests, :type, :string
  end
end
