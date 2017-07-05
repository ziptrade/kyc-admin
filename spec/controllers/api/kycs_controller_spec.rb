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

  context 'When requesting to create a KYC' do
    before do
      post :create, {}
    end

    it 'should create a new KYC and return a Kyc id' do
      expect(Kyc.count).to be 1
      kyc = Kyc.first
      expect(JSON.parse(response.body)).to eq serialized_kyc(kyc)
    end

    it 'should response with a created http status' do
      expect(response).to have_http_status :created
    end

    it 'should not be able to make movements' do
      expect(Kyc.first).not_to be_able_to_make_movements
    end

  end
end
