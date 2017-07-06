require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:user) { create(:user) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  it { should validate_uniqueness_of(:auth_token).ignoring_case_sensitivity }

  it 'initializes the auth token' do
    user = User.new(attributes_for(:user))
    expect(user.auth_token).to_not be_present

    user.save
    expect(user.auth_token).to be_present
  end

  it 'resets auth token' do
    current_token = user.auth_token

    user.reset_auth_token!

    expect(user.auth_token).to be_present
    expect(user.auth_token).not_to eq(current_token)
  end
end
