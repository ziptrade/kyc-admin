require 'rails_helper'

RSpec.describe Applications::SingleSignOn do

  include_context :shared_jwt_context

  let(:auth_application) { double(Clearance::Controller, sign_in: true) }

  let(:sso_app) { Applications::SingleSignOn.new(auth_application, jwt_config) }

  it 'retrieves user with auth token and signs him in' do
    expect(auth_application).to receive(:sign_in).with(user)

    sso_app.authenticate_user_with(jwt_token)
  end

  it 'returns redirect to path extracted from JWT payload' do
    actual_redirect_to_path = sso_app.authenticate_user_with(jwt_token)
    
    expect(actual_redirect_to_path).to eq(redirect_to_path)
  end
  
  context 'user token is invalid' do

    let(:user_auth_token) { 'invalid token' }

    it 'raise an error' do
      expect {
        sso_app.authenticate_user_with(jwt_token)
      }.to raise_error('Invalid User auth token [invalid token]')
    end
  end

end
