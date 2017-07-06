class AddChangesAndStatesToNamespace < ActiveRecord::Migration[5.1]
  def change
    rename_table :states, :states_states
    rename_table :kyc_change_requests, :changes_kyc_change_requests
  end
end
