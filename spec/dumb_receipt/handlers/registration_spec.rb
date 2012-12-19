require 'spec_helper'
require 'dumb_receipt/handlers/registration'

module DumbReceipt
  module Handlers
    describe Registration do
      include Rack::Test::Methods

      it 'inherits DumbReceipt::Handlers::Base' do
        Registration.ancestors.should include DumbReceipt::Handlers::Base
      end

      describe 'POST /registration' do
        it 'responds with success' do
          post '/registration'
          status.should be 200
        end

        it 'fails if you pass a fail parameter' do
          post '/registration', 'fail' => 'yes'
          status.should be 400
        end
      end
    end
  end
end
