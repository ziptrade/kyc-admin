module Sso
  class AuthenticationController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:authorize]

    public :sign_in

    def authorize
      after_sso_path = kyc_application.sso_subsystem.authenticate_user_with(params[:auth_token])

      redirect_to after_sso_path || root_path
    end
  end
end
