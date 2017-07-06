class AddStateBelongsToDocket < ActiveRecord::Migration[5.1]
  def change
    add_belongs_to :states_states, :docket
  end
end
