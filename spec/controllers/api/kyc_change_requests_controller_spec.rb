require 'rails_helper'

RSpec.describe Api::KycChangeRequestsController, type: :controller do
  CHANGE_REQUEST_DATA_ATTRIBUTES = { 'comment' => 'this is a comment' }.freeze
  PERSONAL_DATA_ATTRIBUTES = CHANGE_REQUEST_DATA_ATTRIBUTES.merge(
    'first_name' => 'Roberto',
    'last_name' => 'Carlos',
    'id_number' => '10000000',
    'id_type' => 'DNI'
  ).freeze

  def change_personal_data_for(kyc_id)
    {
      'kyc_id' => kyc_id,
      'data' => {
        'type' => 'personal-data-changes',
        'attributes' => PERSONAL_DATA_ATTRIBUTES
      }
    }
  end

  def assert_has_attribute(attribute, atribute_name)
    attributes = json_body['data']['attributes']
    expect(attributes).to include(atribute_name => attribute)
  end

  def assert_has_relation_with(relation_name)
    relationships = json_body['data']['relationships']
    expect(relationships.keys).to include(relation_name)
  end

  IMAGE_FILE = File.open(File.join(Rails.root, 'spec', 'images', 'bitcoin.png'))
  IMAGE_CONTENT_TYPE = 'image/png'.freeze
  ENCODE64_IMAGE = "data:#{IMAGE_CONTENT_TYPE};base64,#{Base64.encode64(IMAGE_FILE.read)}".freeze

  ATTACHMENT_ATTRIBUTES = CHANGE_REQUEST_DATA_ATTRIBUTES.merge(
    'attachment' => {
      file_data: ENCODE64_IMAGE,
      file_name: 'Document.png',
      file_content_type: IMAGE_CONTENT_TYPE
    }
  ).freeze

  def add_attachment_for(kyc_id)
    {
      'kyc_id' => kyc_id,
      'data' => {
        'type' => 'add-attachments',
        'attributes' => ATTACHMENT_ATTRIBUTES
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

    context 'when requesting to show a change request previously add to the kyc' do
      before do
        kyc = Kyc.find(kyc_id)
        kyc.add_change_request(change_request)
        kyc.save!
        get :show, params: { 'kyc_id' => kyc_id, 'id' => change_request.id }
      end

      context 'and the change request is an add attachment' do
        let(:change_request) { create(:add_attachment) }

        it 'should respond with a serialized add attachment' do
          expect(response).to have_http_status :ok
          assert_has_attribute(change_request.comment, 'comment')
          assert_has_relation_with('kyc-attachment')
        end
      end
    end
  end
end
