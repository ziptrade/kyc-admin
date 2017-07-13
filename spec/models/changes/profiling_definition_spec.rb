require 'rails_helper'

RSpec.describe Changes::ProfilingDefinition, type: :model do
  context 'When having a KYC with minimum valid changes' do
    let(:kyc) { build(:kyc_with_minimum_valid_changes) }
    context 'and defining the profiling and approving those changes' do
      let(:profiling_definition) { build(:profiling_definition) }
      it 'should have the same movement restrictions as the profiling' do
        kyc.add_change_request(profiling_definition)
        kyc.approve
        expect(kyc.movement_restrictions).to eq(profiling_definition.movement_restrictions)
      end
    end
  end
end
