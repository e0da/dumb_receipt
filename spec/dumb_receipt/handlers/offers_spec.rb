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
          error['type'].should == 'OffersNotMarkedAsRead'
          error['message'].should == 'The offers could not be marked as read.'
        end
      end

      describe 'POST /offers/redeem' do

        it 'responds with success and returns the first offer' do
          post '/offers/redeem'
          last_response.status.should be 200
          last_response.headers['Content-Type'].should match %r[application/json]
          JSON.parse(last_response.body)['offer'].should == data['offers'][0]
        end

        it 'fails if you pass a fail parameter' do
          post '/offers/redeem', 'fail' => 'yes'
          last_response.status.should be 400
          error['type'].should == 'OfferNotRedeemed'
          error['message'].should == 'The offer could not be redeemed.'
        end
      end
    end
  end
end
