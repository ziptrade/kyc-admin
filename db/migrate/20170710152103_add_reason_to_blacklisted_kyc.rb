class AddReasonToBlacklistedKyc < ActiveRecord::Migration[5.1]
  def change
    add_belongs_to :states_states, :reason, class_name: 'RejectedReason', index: true
  end
end
