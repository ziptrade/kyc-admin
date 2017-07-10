FactoryGirl.define do
  factory :kyc, class: Kyc do
    initialize_with { Kyc.create_empty! }

    factory :kyc_with_pending_changes do
      after(:build) do |kyc|
        kyc.add_change_request(create(:kyc_change_request))
        kyc.add_change_request(create(:kyc_change_request))
      end

      factory :approved_kyc do
        after(:build) { | kyc | kyc.approve }
      end
    end
  end
end