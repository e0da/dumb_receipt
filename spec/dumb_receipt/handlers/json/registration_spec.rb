require 'spec_helper'
require 'dumb_receipt/handlers/json/registration'

module DumbReceipt
  module Handlers
    module JSON
      describe Registration do
        include Rack::Test::Methods

        it 'inherits DumbReceipt::Handlers::JSON::Base' do
          Registration.ancestors.should include DumbReceipt::Handlers::JSON::Base
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
end
