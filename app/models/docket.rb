class Docket < ApplicationRecord
  has_and_belongs_to_many :kyc_attachments
  has_and_belongs_to_many :movement_restrictions

  def new_copy
    Docket.new(first_name: first_name, last_name: last_name,
               id_number: id_number, id_type: id_type,
               kyc_attachments: kyc_attachments,
               movement_restrictions: movement_restrictions)
  end

  def add_attachment(attachment)
    kyc_attachments.push(attachment)
  end
end
