require 'rails_helper'

RSpec.describe Api::KycsController, type: :controller do

  def serialized_kyc(kyc)
    {
        'data' => {
            'type' => 'kycs',
            'id' => kyc.id.to_s,
            'links' => {
                'self' => '/kycs/' + kyc.id.to_s
            }
        }
    }
  end

  include_context :shared_api_context

  context 'When requesting to create a KYC' do
    it_should_behave_like 'internal server error', :create, lambda { |context| context.allow(Kyc).to context.receive(:create_empty).and_raise('boom') }
    it_should_behave_like 'authorization token is invalid', :create
    it_should_behave_like 'authorization token is valid', :create

    def post_a_valid_message_to_create_a_kyc
      post :create, {}
    end

    def kyc_created
      Kyc.first
    end

    it 'should create a new KYC and return a Kyc id' do
      expect {
        post_a_valid_message_to_create_a_kyc
      }.to change(Kyc, :count).by(1)
    end

    it 'should return a Kyc id' do
      post_a_valid_message_to_create_a_kyc

      assert_json_response_is :created, serialized_kyc(kyc_created)
    end
    
    it 'should not be able to make movements' do
      post_a_valid_message_to_create_a_kyc
      
      expect(kyc_created).not_to be_usable
    end

  end
end
