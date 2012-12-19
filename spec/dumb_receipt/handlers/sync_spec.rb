require 'spec_helper'
require 'dumb_receipt/handlers/sync'

module DumbReceipt
  module Handlers
    describe Sync do
      include Rack::Test::Methods

      it 'inherits DumbReceipt::Handlers::Base' do
        Sync.ancestors.should include DumbReceipt::Handlers::Base
      end

      describe 'GET /sync' do
        it 'returns a sync-like response' do
          get '/sync'
          response['sync_timestamp'].should_not be nil
          response['user'].should_not be nil
          response['offers'].should_not be nil
          response['receipts'].should_not be nil
          response['locations'].should_not be nil
        end
      end
    end
  end
end
