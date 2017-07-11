class CreateKycAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :kyc_attachments do |t|
      t.attachment :file
      t.timestamps
    end
  end
end
