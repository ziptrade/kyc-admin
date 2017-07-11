require 'rails_helper'

RSpec.describe Api::KycChangeRequestsController, type: :controller do

  def change_personal_data_for(kyc_id)
    {
      'kyc_id' => kyc_id,
      'data' => {
        'type' => 'personal-data-changes',
        'attributes' => {
          'first_name' => 'Roberto',
          'last_name' => 'Carlos',
          'id_number' => '10000000',
          'id_type' => 'DNI'
        }
      }
    }
  end
  IMAGE_FILE = File.join(Rails.root, 'spec', 'images', 'bitcoin.png')
  IMAGE_CONTENT_TYPE = 'image/png'.freeze
  ENCODE64_IMAGE = "data:#{IMAGE_CONTENT_TYPE};base64,#{Base64.encode64(IMAGE_FILE)}".freeze

  def add_attachment_for(kyc_id)
    {
      'kyc_id' => kyc_id,
      'data' => {
        'type' => 'add-attachments',
        'attributes' => {
          'attachment' => {
            file_data: ENCODE64_IMAGE,
            file_name: 'Document',
            file_content_type: IMAGE_CONTENT_TYPE
          }
        }
      }
    }
  end

  include_context :shared_api_context

  context 'When having an empty Kyc' do
    let(:kyc_id) { Kyc.create_empty!.id }

    context 'and requesting to change its Personal data' do
      it 'should create a new change request' do
        expect do
          post :create, params: change_personal_data_for(kyc_id)
        end.to change(Changes::PersonalDataChange, :count).by(1)
      end

      it 'still should not be usable' do
        post :create, params: change_personal_data_for(kyc_id)
        expect(Kyc.find(kyc_id)).not_to be_usable
      end

    end

    context 'and requesting to add an attachment' do
      it 'should create a new change request for adding an attachment' do
        expect do
          post :create, params: add_attachment_for(kyc_id)
        end.to change(Changes::AddAttachment, :count).by(1)
      end

      it 'the kyc should have one pending change' do
        post :create, params: add_attachment_for(kyc_id)
        pending_change = Kyc.find(kyc_id).state
        expect(pending_change.change_requests.size).to eq(1)
      end
    end
  end
end
