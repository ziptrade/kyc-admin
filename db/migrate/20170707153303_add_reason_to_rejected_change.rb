class AddReasonToRejectedChange < ActiveRecord::Migration[5.1]
  def change
    add_column :states_states, :reasons, :string
  end
end
