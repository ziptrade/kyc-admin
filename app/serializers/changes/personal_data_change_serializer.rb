module Changes
  class PersonalDataChangeSerializer
    include JSONAPI::Serializer

    attribute :first_name
    attribute :last_name
    attribute :id_number
    attribute :id_type
  end
end