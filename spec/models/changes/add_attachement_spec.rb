require 'rails_helper'

RSpec.describe Changes::AddAttachment, type: :model do
  context 'When having an approved Kyc' do
    let(:kyc) { build(:kyc_with_minimum_valid_changes) }
    context 'and adding it an attachment' do
      let(:add_attachment) { build(:add_attachment) }
      before do
        kyc.add_change_request(add_attachment)
      end
      context 'and approving that change' do
        it 'should attach that to the docket' do
          expect do
            kyc.approve
          end.to(change { kyc.docket.kyc_attachments.size }.by(1))
        end
      end
    end
  end
end