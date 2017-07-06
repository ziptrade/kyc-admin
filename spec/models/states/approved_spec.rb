require 'rails_helper'

RSpec.describe States::Approved, type: :model do

  context 'When having a kyc with pending changes' do
    let(:kyc) {
      kyc = Kyc.create_empty
      kyc.add_change_request(create(:kyc_change_request))
      kyc.add_change_request(create(:kyc_change_request))
      kyc
    }

    context 'and approving the kyc' do

      it 'should change its state to Approved' do
        expect do
          kyc.approve
        end.to change { kyc.state }
        expect(kyc.state).to be_a(States::Approved)
      end

      it 'should be usable' do
        kyc.approve
        expect(kyc).to be_usable
      end

    end

  end

end