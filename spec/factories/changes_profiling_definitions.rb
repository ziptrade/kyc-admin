FactoryGirl.define do
  factory :profiling_definition, class: 'Changes::ProfilingDefinition' do
    transient do
      restrictions_count 2
    end

    after(:build) do |profiling_definition, evaluator|
      build_list(:movement_restriction, evaluator.restrictions_count, profiling_definition: profiling_definition)
    end
  end
end
