FactoryGirl.define do
  factory :kyc, class: Kyc do
    initialize_with { Kyc.create_empty! }

    factory :kyc_with_pending_changes, aliases: [:kyc_with_minimum_valid_changes] do
      after(:build) do |kyc|
        kyc.add_change_request(create(:kyc_change_request))
        kyc.add_change_request(create(:kyc_change_request))
      end

      factory :approved_kyc, aliases: [:kyc_with_no_movements] do
        after(:build, &:approve)
      end
    end
  end
end
