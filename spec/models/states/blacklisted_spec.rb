require 'rails_helper'

RSpec.describe States::Blacklisted, type: :model do
  context 'When having an approved Kyc' do
    let(:kyc) { create(:approved_kyc) }

    context 'and the kyc is blacklisted due to suspicious behaviour' do
      let(:reason) { build(:rejected_reason) }

      it 'should change its state to Blacklisted' do
        expect do
          kyc.blacklist(reason)
        end.to(change { kyc.state })
        expect(kyc.state).to be_a(States::Blacklisted)
      end

      it 'should not be usable' do
        kyc.blacklist(reason)
        expect(kyc).not_to be_usable
      end

      it 'should have the reason why it was blacklisted' do
        kyc.blacklist(reason)
        blacklisted_state = kyc.state
        expect(blacklisted_state.reason).to eq(reason)
      end

      it 'should have exactly the same docket as before' do
        expect do
          kyc.blacklist(reason)
        end.not_to(change { kyc.docket })
      end

      context 'and new changes are requested' do
        let(:kyc_change_request) { create(:kyc_change_request) }
        before do
          kyc.blacklist(reason)
        end

        it 'should not be able to make those changes due to be blacklisted' do
          expect do
            kyc.add_change_request(kyc_change_request)
          end.to(raise_error(StandardError, States::Blacklisted::CANT_MAKE_CHANGE_REQUEST_ERROR))
          expect(kyc.state).to be_a(States::Blacklisted)
        end
      end

      context 'and it is removed from the blacklist' do
        it 'should return to its previous state' do
          expect do
            kyc.blacklist(reason)
            kyc.remove_from_blacklist
          end.not_to(change { kyc.state })
        end
      end
    end
  end
end
