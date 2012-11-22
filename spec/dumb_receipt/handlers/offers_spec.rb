require 'spec_helper'
require 'dumb_receipt/handlers/offers'

module DumbReceipt
  module Handlers
    describe Offers do
      include Rack::Test::Methods

      def app
        DumbReceipt::Handlers::Offers
      end

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

      describe 'POST /offers/read' do
        it 'responds with success' do
          post '/offers/read'
          last_response.status.should be 200
        end

        it 'fails if you pass a fail parameter' do
          post '/offers/read', 'fail' => 'yes'
          last_response.status.should be 400
          error['type'].should == 'OffersNotRedeemed'
          error['message'].should == 'The offers could not all be redeemed.'
        end
      end

      describe 'POST /offers/redeem' do

      end
    end
  end
end
