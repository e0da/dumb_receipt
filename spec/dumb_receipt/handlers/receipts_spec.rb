require 'spec_helper'
require 'dumb_receipt/handlers/receipts'

module DumbReceipt
  module Handlers
    describe Receipts do
      include Rack::Test::Methods

      def app
        DumbReceipt::Handlers::Receipts
      end

      describe 'GET /receipts' do
        it 'renders the results as JSON' do
          get '/receipts'
          last_response.headers['Content-Type'].should match %r[application/json]
          JSON.parse(last_response.body)['receipts'].length.should == data['receipts'].length
        end

        it 'honors the limit parameter' do
          get '/receipts', 'limit' => 37
          JSON.parse(last_response.body)['receipts'].length.should == 37
        end
      end

      describe 'POST /receipts/add' do

        it 'returns a sample receipt when you add any identifier' do
          post '/receipts/add', 'identifier' => 'waka%20fula%20kasu%20tylu'
          last_response.status.should be 200
          last_response.headers['Content-Type'].should match %r[application/json]
          json = JSON.parse(last_response.body)
          json['receipt'].should_not be nil
          json['offers'].length.should be 2
          json['location'].should_not be nil
        end

        context 'when you specify a fail parameter' do

          it 'gives a 403 when receipt is already associated' do

            post '/receipts/add',
              'identifier' => 'waka%20fula%20kasu%20tylu',
              'fail' => 'ReceiptAlreadyAssociated'

            last_response.status.should be 403
            json = JSON.parse(last_response.body)
            json['type'].should == 'ReceiptAlreadyAssociated'
            json['message'].should == 'This receipt has already been claimed by another user'
          end

          it 'gives a 404 when the receipt is not found' do

            post '/receipts/add',
              'identifier' => 'waka%20fula%20kasu%20tylu',
              'fail' => 'ReceiptNotFound'

            last_response.status.should be 404
            json = JSON.parse(last_response.body)
            json['type'].should == 'ReceiptNotFound'
            json['message'].should == 'We could not find a receipt matching identifier: waka fula kasu tylu'
          end
        end
      end
    end
  end
end
