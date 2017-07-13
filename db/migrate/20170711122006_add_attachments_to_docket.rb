class AddAttachmentsToDocket < ActiveRecord::Migration[5.1]
  def change
    create_table :dockets_kyc_attachments do |t|
      t.belongs_to :docket
      t.belongs_to :kyc_attachment
    end
  end
end
