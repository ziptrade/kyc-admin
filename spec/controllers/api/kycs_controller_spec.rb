require 'rails_helper'

RSpec.describe Api::KycsController, type: :controller do
  include_context :shared_api_context

  def serialized_related_state(kyc, type)
    { 'data' => { 'type' => type, 'id' => kyc.state.id.to_s } }
  end

  def serialized_kyc_data(kyc)
    {
      'type' => 'kycs',
      'id' => kyc.id.to_s,
      'links' => {
        'self' => '/kycs/' + kyc.id.to_s
      }
    }
  end

  def assert_has_basic_kyc_data(kyc, response)
    body = JSON.parse(response.body)
    data = body['data']
    expect(data).to include(serialized_kyc_data(kyc))
  end

  def assert_has_relation_with_state(kyc, type)
    related_state = json_body['data']['relationships']['state']
    expect(related_state).to include(serialized_related_state(kyc, type))
  end

  context 'When requesting to create a KYC' do
    def post_a_valid_message_to_create_a_kyc
      post :create, {}
    end

    def kyc_created
      Kyc.first
    end

    it 'should create a new KYC' do
      expect do
        post_a_valid_message_to_create_a_kyc
      end.to change(Kyc, :count).by(1)
    end

    it 'should return a Kyc id' do
      post_a_valid_message_to_create_a_kyc
      expect(response).to have_http_status :created
      assert_has_basic_kyc_data(kyc_created, response)
    end

    it 'should not be usable' do
      post_a_valid_message_to_create_a_kyc
      expect(kyc_created).not_to be_usable
    end
  end

  context 'When requesting to show' do
    before do
      get :show, params: { id: kyc.id }
    end
    context 'an empty KYC' do
      let(:kyc) { create(:empty_kyc) }

      it 'should respond with a serialized kyc with an empty state included' do
        expect(response).to have_http_status :ok
        assert_has_basic_kyc_data(kyc, response)
        assert_has_relation_with_state(kyc, 'empties')
      end
    end

    context 'a KYC with a change request' do
      let(:change_request) { create(:add_attachment) }
      let(:kyc) do
        kyc = create(:empty_kyc)
        kyc.add_change_request(change_request)
        kyc.save!
        kyc
      end

      it 'should respond with a serialized kyc with a pending change state included' do
        expect(response).to have_http_status :ok
        assert_has_basic_kyc_data(kyc, response)
        assert_has_relation_with_state(kyc, 'pending-changes')
      end
    end
  end
end
