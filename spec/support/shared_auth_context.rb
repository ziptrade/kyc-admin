shared_context :shared_auth_context do
  def assert_user_is_signed_in(user)
    # TODO: Is there a Clearence helper available in test env to retrieve user/check signed in?
    expect(@request.env[:clearance].current_user).to eq(user)
  end
end
