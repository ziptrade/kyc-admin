require 'rails_helper'

def reject_changes(reason)
  kyc_with_pending_changes.reject_changes(reason)
end

RSpec.describe States::AmendmentsRequested, type: :model do

  context 'When having a Kyc with pending changes' do
    let(:kyc_with_pending_changes) { create(:kyc_with_pending_changes) }

    context 'and the changes are rejected' do
      let(:reasons_to_be_rejected) { 'This are the reasons why I reajected the changes' }

      it 'should change its state to RejectedChange' do
        expect do
          reject_changes(reasons_to_be_rejected)
        end.to change { kyc_with_pending_changes.state }
        expect(kyc_with_pending_changes.state).to be_a(States::AmendmentsRequested)
      end

      it 'should not be usable' do
        reject_changes(reasons_to_be_rejected)
        expect(kyc_with_pending_changes).not_to be_usable
      end

      it 'should have the reason why it was rejected' do
        reject_changes(reasons_to_be_rejected)
        rejected_change_state = kyc_with_pending_changes.state
        expect(rejected_change_state.reasons).to eq(reasons_to_be_rejected)
      end

      it 'should already have the change requests made before' do
        change_requests = kyc_with_pending_changes.state.change_requests
        reject_changes(reasons_to_be_rejected)
        expect(kyc_with_pending_changes.state.change_requests).to eq(change_requests)
      end

      context 'and new changes are requested' do
        let(:kyc_change_request) { create(:kyc_change_request) }
        before do
          reject_changes(reasons_to_be_rejected)
        end

        it 'should return to PendingChange state' do
          expect do
            kyc_with_pending_changes.add_change_request(kyc_change_request)
          end.to change { kyc_with_pending_changes.state }
          expect(kyc_with_pending_changes.state).to be_a(States::PendingChange)
        end
      end
    end
  end
end
