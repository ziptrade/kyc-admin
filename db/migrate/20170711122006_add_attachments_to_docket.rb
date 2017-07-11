class AddAttachmentsToDocket < ActiveRecord::Migration[5.1]
  def change
    create_table :dockets_kyc_attachments do |t|
      t.belongs_to :dockets
      t.belongs_to :kyc_attachments
    end
  end
end
