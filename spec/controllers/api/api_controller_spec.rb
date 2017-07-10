require 'rails_helper'

RSpec.describe Api::ApiController, type: :controller do

  controller do
      def index
        Kyc.create_empty!
      end
  end

  include_context :shared_api_context

  it_should_behave_like 'internal server error', :index, lambda { |context| context.allow(Kyc).to context.receive(:create_empty!).and_raise('boom') }
  it_should_behave_like 'authorization token is invalid', :index
  it_should_behave_like 'authorization token is valid', :index

end
