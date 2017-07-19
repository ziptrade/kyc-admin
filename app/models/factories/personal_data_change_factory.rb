module Factories
  class PersonalDataChangeFactory < ChangeFactory
    def build_from(params)
      Changes::PersonalDataChange.create!(personal_data_params(params))
    end

    private

    def personal_data_params(params)
      params.permit(:first_name, :last_name, :id_number, :id_type).merge(change_request_params(params))
    end
  end
end
