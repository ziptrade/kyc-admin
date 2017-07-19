require 'rails_helper'

RSpec.describe JWTAuthentication::Decoder do
  
  include_context :shared_jwt_context

  context 'valid JWT token' do
    it 'extracts user token and redirect to path' do
      actual_user_token, actual_redirect_to_path = jwt_decoder.decode(jwt_token)

      expect(actual_user_token).to eq(user_auth_token)
      expect(actual_redirect_to_path).to eq(redirect_to_path)
    end
  end

  context 'auth token is missing' do
    let(:private_data) { Hash.new }

    it 'should raise an error' do
      expect {
        jwt_decoder.decode(jwt_token)
      }.to raise_error(/User authentication token is missing/)
    end
  end

  context 'invalid secret' do
    let(:invalid_secret) { 'not a valid secret' }
    let(:invalid_jwt_token) { encode_jwt( payload, invalid_secret, jwt_config.algorithm) }

    it 'should raise an error' do
      expect {
        jwt_decoder.decode(invalid_jwt_token)
      }.to raise_error(JWT::VerificationError, 'Signature verification raised')
    end
  end

  context 'invalid algorithm' do
    let(:invalid_algorithm) { 'HS512' }
    let(:invalid_jwt_token) { encode_jwt( payload, jwt_config.hmac_secret, invalid_algorithm) }

    it 'should raise an error' do
      expect {
        jwt_decoder.decode(invalid_jwt_token)
      }.to raise_error(JWT::IncorrectAlgorithm, 'Expected a different algorithm')
    end
  end

  context 'message is expired' do
    let(:current_time) { Time.now.yesterday.to_i }

    it 'should raise an error' do
      expect {
        jwt_decoder.decode(jwt_token)
      }.to raise_error(JWT::ExpiredSignature, 'Signature has expired')
    end
  end

  context 'message is in the future' do
    let(:current_time) { Time.now.tomorrow.to_i }

    it 'should raise an error' do
      expect {
        jwt_decoder.decode(jwt_token)
      }.to raise_error(JWT::ImmatureSignature, 'Signature nbf has not been reached')
    end
  end

  context 'invalid issuer' do
    let(:issuer) { 'Ethereum.la' }

    it 'should raise an error' do
      expect {
        jwt_decoder.decode(jwt_token)
      }.to raise_error(JWT::InvalidIssuerError, 'Invalid issuer. Expected Bitex.la, received Ethereum.la')
    end
  end

end
