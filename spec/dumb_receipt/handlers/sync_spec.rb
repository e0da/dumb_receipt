require 'spec_helper'
require 'dumb_receipt/handlers/sync'

module DumbReceipt
  module Handlers
    describe Sync do
      include Rack::Test::Methods

      describe 'GET /sync' do
        it 'renders the results as JSON' do
          get '/sync'
          last_response.headers['Content-Type'].should match %r[application/json]
          json = JSON.parse(last_response.body)
          json['sync_timestamp'].should_not be nil
          json['user'].should_not be nil
          json['offers'].length.should be > 1
          json['receipts'].length.should be > 1
        end
      end
    end
  end
end
