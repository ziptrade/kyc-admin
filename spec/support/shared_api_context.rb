shared_context :shared_api_context do

  def assert_json_response_is status, expected_json_response
    expect(response.content_type).to eq('application/json')

    actual_json_response = JSON.parse(response.body)
    expect(actual_json_response).to eq(expected_json_response)

    expect(response).to have_http_status status
  end

  let(:user) { create(:user) }
  let(:api_token) { user.auth_token }

  let(:failed_response) do
    {
      'success' => false,
      'error' => error_message
    }
  end

  before :each do
    request.env['HTTP_AUTHORIZATION'] = 'Token token=' + api_token
  end

  shared_examples_for 'internal server error' do |action, simulate_internal_error_block|
    let(:error_message) { 'boom' }

    it 'returns an internal server error' do
      simulate_internal_error_block.call(self)

      post action, :format => :json

      assert_json_response_is 500, failed_response
    end
  end

  shared_examples_for 'authorization token is invalid' do |action|
    let(:error_message) { 'unauthorized' }
    let(:api_token) { 'invalid auth token' }

    it 'returns an unauthorized' do
      post action, :format => :json

      assert_json_response_is 401, failed_response
    end
  end

  shared_examples_for 'authorization token is valid' do |action|

    it 'signs in user' do
      post action, :format => :json

      # TODO: Is there a Clearence helper available in test env to retrieve user/check signed in?
      expect(@request.env[:clearance].current_user).to be_present
    end
  end


end