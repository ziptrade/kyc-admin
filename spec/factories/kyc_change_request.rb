FactoryGirl.define do
  factory :kyc_change_request, class: 'Changes::PersonalDataChange' do
    first_name 'Roberto'
    last_name 'Carlos'
    id_number '10000000'
    id_type 'DNI'
  end
end
