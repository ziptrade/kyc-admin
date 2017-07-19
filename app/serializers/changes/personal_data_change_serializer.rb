module Changes
  class PersonalDataChangeSerializer < Changes::KycChangeRequestSerializer
    attribute :first_name
    attribute :last_name
    attribute :id_number
    attribute :id_type
  end
end
