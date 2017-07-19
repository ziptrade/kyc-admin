class AddCommentToChangeRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :changes_kyc_change_requests, :comment, :text
  end
end
