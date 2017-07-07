require 'rails_helper'

RSpec.describe States, type: :model do
  context 'When having an empty Kyc' do
    let(:kyc) { Kyc.create_empty! }

    context 'and adding changes' do
      let(:change_request) { create(:kyc_change_request) }

      it 'the kyc should be in a pending change states' do
        expect do
          kyc.add_change_request(change_request)
        end.to change { kyc.state }
        expect(kyc.state).to be_a(States::PendingChange)
      end

      it 'its pending changes should be the changes added' do
        kyc.add_change_request(change_request)
        expect(kyc.state.change_requests).to include(change_request)
      end

      context 'and adding another change' do
        let(:another_change_request) { create(:kyc_change_request) }
        before do
          kyc.add_change_request(change_request)
        end

        it 'the kyc should be in a pending change states' do
          expect do
            kyc.add_change_request(another_change_request)
          end.not_to change { kyc.state }
        end

        it 'its pending changes should be the changes added' do
          kyc.add_change_request(another_change_request)
          expect(kyc.state.change_requests).to eq([change_request, another_change_request])
        end

      end

    end

  end
end
