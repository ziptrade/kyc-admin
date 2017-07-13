FactoryGirl.define do
  factory :add_attachment, class: 'Changes::AddAttachment' do
    association :kyc_attachment
  end
end
