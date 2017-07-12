module Api
  class KycChangeRequestsController < Api::ApiController
    def create
      kyc = Kyc.find(params.require(:kyc_id))
      change_request = change_request_from_params
      kyc.add_change_request(change_request)
      kyc.save!
      render json: JSONAPI::Serializer.serialize(change_request), status: :created
    end

    private

    def change_request_from_params
      Factories::ChangeFactory.for(change_type).create_from!(change_params)
    end

    def change_type
      params.require(:data).require(:type)
    end

    def change_params
      params.require(:data)
            .require(:attributes)
    end
  end
end
