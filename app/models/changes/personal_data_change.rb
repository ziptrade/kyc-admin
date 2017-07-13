module Changes
  class PersonalDataChange < Changes::KycChangeRequest
    def apply(docket)
      docket.first_name = first_name
      docket.last_name = last_name
      docket.id_number = id_number
      docket.id_type = id_type
    end
  end
end
