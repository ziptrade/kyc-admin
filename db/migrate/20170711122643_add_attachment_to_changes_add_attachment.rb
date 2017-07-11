class AddAttachmentToChangesAddAttachment < ActiveRecord::Migration[5.1]
  def change
    add_belongs_to :changes_kyc_change_requests, :kyc_attachment
  end
end
