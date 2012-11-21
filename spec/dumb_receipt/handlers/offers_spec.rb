require 'spec_helper'
require 'dumb_receipt/handlers/offers'

module DumbReceipt
  module Handlers
    describe Offers do
      include Rack::Test::Methods

      describe 'GET /offers' do
        it 'renders the results as JSON' do
          get '/offers'
          last_response.headers['Content-Type'].should match %r[application/json]
          JSON.parse(last_response.body)['offers'].length.should == data['offers'].length
        end

        it 'honors the limit parameter' do
          get '/offers', 'limit' => 37
          JSON.parse(last_response.body)['offers'].length.should == 37
        end
      end
    end
  end
end
