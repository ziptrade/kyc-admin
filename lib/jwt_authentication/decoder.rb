module JWTAuthentication
  class Decoder
    def initialize(jwt_config)
      @jwt_config = jwt_config
    end

    def decode(auth_token)
      decoded_token = JWT.decode(auth_token, hmac_secret, true, jwt_options)

      private_data = decoded_token.detect { |dict| dict.key? 'data' }

      raise "Invalid JWT token #{decoded_token}. User authentication token is missing" unless valid?(private_data)

      [user_token(private_data), redirect_to_path(private_data)]
    end

    private

    def jwt_options
      {
        verify_iat: true,
        iss: issuer,
        verify_iss: true,
        leeway: leeway,
        algorithm: algorithm
      }
    end

    def valid?(private_data)
      private_data && private_data['data'] && private_data['data'].key?('user_auth_token')
    end

    def user_token(private_data)
      private_data['data']['user_auth_token']
    end

    def redirect_to_path(private_data)
      private_data['data']['redirect_to']
    end

    def hmac_secret
      @jwt_config.hmac_secret
    end

    def leeway
      @jwt_config.leeway
    end

    def issuer
      @jwt_config.issuer
    end

    def algorithm
      @jwt_config.algorithm
    end
  end
end
