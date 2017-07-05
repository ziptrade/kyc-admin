require 'jsonapi-serializers'
module Api
  class KycsController < Api::ApiController
    def create
      kyc = Kyc.create_empty
      render json: JSONAPI::Serializer.serialize(kyc), status: :created
    end
  end
end