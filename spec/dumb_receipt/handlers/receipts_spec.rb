require 'spec_helper'
require 'dumb_receipt/handlers/receipts'

module DumbReceipt
  module Handlers
    describe Receipts do
      include Rack::Test::Methods

      it 'inherits DumbReceipt::Handlers::Base' do
        Receipts.ancestors.should include DumbReceipt::Handlers::Base
      end

      describe 'GET /receipts' do

        it 'returns the receipts' do
          get '/receipts'
          response_data['receipts'].should == data['receipts']
        end

        it 'returns offers' do
          get '/receipts'
          response_data['offers'].should == data['offers']
        end

        it 'returns locations' do
          get '/receipts'
          response_data['locations'].should == data['locations']
        end

        it 'honors the limit parameter' do
          get '/receipts', 'limit' => 37
          response_data['receipts'].length.should == 37
        end
      end

      describe 'POST /receipts/add' do

        it 'returns a sample receipt when you add any identifier' do
          post '/receipts/add', 'identifier' => 'waka%20fula%20kasu%20tylu'
          last_response.status.should be 200
          response_data['receipt'].should_not be nil
          response_data['offers'].length.should be 2
          response_data['location'].should_not be nil
        end

        context 'when you specify a fail parameter' do

          it 'gives a 403 when receipt is already associated' do

            post '/receipts/add',
              'identifier' => 'waka%20fula%20kasu%20tylu',
              'fail' => 'ReceiptAlreadyAssociated'

            last_response.status.should be 403
            error['type'].should == 'ReceiptAlreadyAssociated'
            error['message'].should == 'This receipt has already been claimed by another user'
          end

          it 'gives a 404 when the receipt is not found' do

            post '/receipts/add',
              'identifier' => 'waka%20fula%20kasu%20tylu',
              'fail' => 'ReceiptNotFound'

            last_response.status.should be 404
            error['type'].should == 'ReceiptNotFound'
            error['message'].should == 'We could not find a receipt matching identifier: waka fula kasu tylu'
          end
        end
      end

      describe 'POST /receipts/email' do

        it 'responds with success' do
          post '/receipts/email'
          last_response.status.should be 200
        end

        context 'when you specify a fail parameter' do

          it 'gives a 404 when the receipt is not found or does not belong to the user' do
            post '/receipts/email', 'fail' => 'ReceiptNotFound'
            last_response.status.should be 404
            error['type'].should == 'ReceiptNotFound'
            error['message'].should == 'We could not email the receipt you selected because it could not be found.'
          end

          it 'gives a 400 when the email is invalid or the receipt UUID is missing' do
            post '/receipts/email', 'fail' => 'InvalidEmailOrMissingReceiptUUID'
            last_response.status.should be 400
            error['type'].should == 'InvalidEmailOrMissingReceiptUUID'
            error['message'].should == [
              'We could not email the receipt you selected because the email',
              ' address is invalid or the receipt UUID is missing.'
            ] * ''
          end
        end
      end

      describe 'DELETE /receipts/:id' do

        it 'responds with success' do
          delete '/receipts/some-fake-id' do
            last_response.status.should be 200
          end
        end

        it 'responds with 400 and an error message if you tell it to fail' do
          delete '/receipts/some-fake-id', 'fail' => 'yes'
          last_response.status.should be 400
          error['type'].should == 'ReceiptNotDeleted'
          error['message'].should == 'The receipt was not deleted'
        end
      end
    end
  end
end
