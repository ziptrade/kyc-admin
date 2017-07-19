require 'jsonapi-serializers'
module Api
  class KycsController < Api::ApiController
    def create
      kyc = Kyc.create_empty!
      render json: JSONAPI::Serializer.serialize(kyc), status: :created
    end

    def show
      kyc = Kyc.find(params.require(:id))
      render json: JSONAPI::Serializer.serialize(kyc, include: 'state'), status: :ok
    end
  end
end
