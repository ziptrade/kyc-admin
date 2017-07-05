class AddKycBelongsToChangeRequest < ActiveRecord::Migration[5.1]
  def change
    add_belongs_to :kycs, :kyc_change_request, index: true
  end
end
