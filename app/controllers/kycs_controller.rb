require 'jsonapi-serializers'

class KycsController < ApplicationController
  def create
    kyc = Kyc.create_empty
    render json: JSONAPI::Serializer.serialize(kyc), status: :created
  end
end
