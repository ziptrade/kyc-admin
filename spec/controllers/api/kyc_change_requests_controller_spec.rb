require 'rails_helper'

RSpec.describe Api::KycChangeRequestsController, type: :controller do

  def serialized_change_request_for(kyc_id)
    {
        'kyc_id' => kyc_id,
        'data' => {
            'type' => 'kyc-change-requests',
            'attributes' => {
                'first_name' => 'Roberto',
                'last_name' => 'Carlos',
                'id_number' => '10000000',
                'id_type' => 'DNI'
            }
        }
    }
  end

  include_context :shared_api_context
  
  context 'When having an empty Kyc' do
    let(:kyc_id) { Kyc.create_empty!.id }

    context 'and requesting to change its information' do

      it 'should create a new change request' do
        expect {
          post :create, params: serialized_change_request_for(kyc_id)
        }.to change(Changes::KycChangeRequest, :count).by(1)
      end

      it 'still should not be able to make movements' do
        post :create, params: serialized_change_request_for(kyc_id)

        expect(Kyc.find(kyc_id)).not_to be_usable
      end
    end
  end

end
