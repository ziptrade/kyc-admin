module Applications
  class SingleSignOn

    def initialize(auth_application, jwt_config)
      @auth_application = auth_application
      @jwt_config = jwt_config
    end

    def authenticate_user_with(auth_token)
      user_auth_token, redirect_to_path = jwt_decoder.decode(auth_token)

      @auth_application.sign_in find_user_by(user_auth_token)

      redirect_to_path
    end

    private

    def find_user_by(user_auth_token)
      user = User.find_by(auth_token: user_auth_token)

      raise "Invalid User auth token [#{user_auth_token}]" unless user.present?
      user
    end
    
    def jwt_decoder
      JWTAuthentication::Decoder.new(@jwt_config)
    end
  end
end