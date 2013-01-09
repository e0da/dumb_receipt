require 'spec_helper'
require 'dumb_receipt/handlers/json/stats'

module DumbReceipt
  module Handlers
    module JSON
      describe Stats do
        include Rack::Test::Methods

        it 'inherits DumbReceipt::Handlers::JSON::Base' do
          Stats.ancestors.should include DumbReceipt::Handlers::JSON::Base
        end

        describe 'GET /stats' do
          it 'returns the stats' do
            get '/stats'
            response['stats'].should == data['stats']
          end
        end
      end
    end
  end
end
