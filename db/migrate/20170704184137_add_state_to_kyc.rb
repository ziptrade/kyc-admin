class AddStateToKyc < ActiveRecord::Migration[5.1]
  def change
    add_belongs_to :kycs, :state
  end
end
