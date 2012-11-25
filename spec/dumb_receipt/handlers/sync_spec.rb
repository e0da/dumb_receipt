require 'spec_helper'
require 'dumb_receipt/handlers/sync'

module DumbReceipt
  module Handlers
    describe Sync do
      include Rack::Test::Methods

      def app
        DumbReceipt::Handlers::Sync
      end

      describe 'GET /sync' do
        it 'returns a sync-like response' do
          get '/sync'
          response_data['sync_timestamp'].should_not be nil
          response_data['user'].should_not be nil
          response_data['offers'].length.should_not be nil
          response_data['receipts'].length.should_not be nil
        end
      end
    end
  end
end
