class Docket < ApplicationRecord
  has_and_belongs_to_many :kyc_attachments

  def new_copy
    Docket.new(first_name: first_name, last_name: last_name,
               id_number: id_number, id_type: id_type,
               kyc_attachments: kyc_attachments)
  end

  def add_attachment(attachment)
    kyc_attachments.push(attachment)
  end
end
