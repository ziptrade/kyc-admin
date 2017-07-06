class RemoveKycBelongToKycChangeRequest < ActiveRecord::Migration[5.1]
  def up
    remove_column :kycs, :kyc_change_request_id if column_exists?(:kycs, :kyc_change_request_id)
  end

  def down

  end
end
