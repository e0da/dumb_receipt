require 'spec_helper'
require 'dumb_receipt/handlers/offers'

module DumbReceipt
  module Handlers
    describe Offers do
      include Rack::Test::Methods

      it 'inherits DumbReceipt::Handlers::Base' do
        Offers.ancestors.should include DumbReceipt::Handlers::Base
      end

      describe 'GET /offers' do

        it 'returns the offers' do
          get '/offers'
          response['offers'].should == data['offers']
        end

        it 'honors the limit parameter' do
          get '/offers', 'limit' => 37
          response['offers'].length.should == 37
        end
      end

      describe 'POST /offers/read' do

        it 'responds with success' do
          post '/offers/read'
          status.should be 200
        end

        it 'fails if you pass a fail parameter' do
          post '/offers/read', 'fail' => 'yes'
          status.should be 400
          error['type'].should == 'OffersNotMarkedAsRead'
          error['message'].should == 'The offers could not be marked as read.'
        end
      end

      describe 'POST /offers/redeem' do

        it 'responds with success and returns the first offer' do
          post '/offers/redeem'
          status.should be 200
          response['offer'].should == data['offers'][0]
        end

        it 'fails if you pass a fail parameter' do
          post '/offers/redeem', 'fail' => 'yes'
          status.should be 400
          error['type'].should == 'OfferNotRedeemed'
          error['message'].should == 'The offer could not be redeemed.'
        end
      end
    end
  end
end
