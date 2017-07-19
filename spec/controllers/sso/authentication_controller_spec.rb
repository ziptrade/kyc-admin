require 'rails_helper'

RSpec.describe Sso::AuthenticationController, type: :controller do

  include_context :shared_jwt_context
  include_context :shared_auth_context

  it 'should redirect to path set in the JWT payload' do

    get :authorize, params: {auth_token: jwt_token}

    expect(response).to redirect_to(user_path(user))
  end

  context 'JWT payload does not include redirect path' do

    let(:redirect_to_path) { nil }
    
    it 'should redirect to root path' do

      get :authorize, params: {auth_token: jwt_token}

      expect(response).to redirect_to(root_path)
    end
  end


  it 'should sign in the user' do

    get :authorize, params: {auth_token: jwt_token}

    assert_user_is_signed_in(user)
  end
end