require 'rails_helper'

RSpec.describe States::Approved, type: :model do

  context 'When having a kyc with pending changes' do
    let(:kyc) { create(:kyc_with_pending_changes) }

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

      context 'and requesting to make new changes' do
        let(:change_request) { build(:kyc_change_request) }
        before do
          kyc.approve
        end

        it 'should change to PendingChange state' do
          expect do
            kyc.add_change_request(change_request)
          end.to change { kyc.state }
          expect(kyc.state).to be_a(States::PendingChange)
        end
      end

    end

  end

end