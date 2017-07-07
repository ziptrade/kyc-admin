module Api
  class KycChangeRequestsController < Api::ApiController

    def create
      kyc = Kyc.find(params.require(:kyc_id))
      change_request = Changes::KycChangeRequest.new(changes_params)
      kyc.add_change_request(change_request)
      kyc.save!

    end

    private
      def changes_params
        params.require(:data)
          .require(:attributes)
          .permit(:first_name, :last_name, :id_number, :id_type)
      end
  end
end