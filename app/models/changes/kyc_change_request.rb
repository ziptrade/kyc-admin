class Changes::KycChangeRequest < ApplicationRecord

  def apply(docket)
    docket.first_name = self.first_name
    docket.last_name = self.last_name
    docket.id_number = self.id_number
    docket.id_type = self.id_type
  end
end