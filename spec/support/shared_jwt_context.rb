shared_context :shared_jwt_context do

  def encode_jwt(payload, secret, algorithm)
    JWT.encode payload, secret, algorithm
  end

  let(:current_time) { Time.now.to_i }
  let(:jwt_config) { JWTAuthentication::Config.for_development_and_test }
  let(:user) { create(:user) }
  let(:user_auth_token) { user.auth_token }
  let(:redirect_to_path) { "/users/#{user.id}" }
  let(:issuer) { jwt_config.issuer }

  let(:payload) do
    {
      data: private_data,
      exp: current_time + jwt_config.expires_in,
      nbf: current_time - jwt_config.expires_in,
      iss: issuer,
      iat: current_time
    }
  end

  let(:private_data) do
    {:user_auth_token => user_auth_token, redirect_to: redirect_to_path}
  end

  let(:jwt_token) { encode_jwt( payload, jwt_config.hmac_secret, jwt_config.algorithm) }
  let(:jwt_decoder) { JWTAuthentication::Decoder.new(jwt_config) }

end