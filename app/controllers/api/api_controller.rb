module Api
  class ApiController < ActionController::Base
    include Clearance::Controller
    include AppendLoggerInfo

    before_action :authenticate_api_token!

    rescue_from StandardError do |error|
      handle_api_error(error, :internal_server_error)
    end

    private

    def authenticate_api_token!
      user = fetch_user_with_token
      if user.present?
        logger.info "API AUTH: User [#{user.id}-#{user.email}] authorized"
        sign_in user
      else
        logger.info 'API AUTH: Invalid token received. Authorization denied'
        headers['WWW-Authenticate'] = 'Token realm="Application"'
        render json: { success: false, error: 'unauthorized' }, status: :unauthorized
      end
    end

    def fetch_user_with_token
      authenticate_with_http_token do |api_token, _options|
        User.find_by(auth_token: api_token)
      end
    end

    def handle_api_error(error, http_error_code)
      logger.error error.message
      logger.error error.backtrace.join("\n")

      render json: { success: false, error: error.message }, status: http_error_code
    end
  end
end
