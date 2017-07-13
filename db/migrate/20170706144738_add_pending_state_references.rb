class AddPendingStateReferences < ActiveRecord::Migration[5.1]
  def change
    add_belongs_to :states_states, :previous_state, :class_name => 'States::State', index: true
    add_belongs_to :changes_kyc_change_requests, :states_states, index: true, foreign_key: 'pending_state_id'
  end
end
