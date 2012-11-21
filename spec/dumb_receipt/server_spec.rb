require 'spec_helper'

require 'dumb_receipt/server'
require 'json'

describe DumbReceipt::Server do

  describe 'routes', type: :feature do
    include Rack::Test::Methods

    describe 'GET' do

      describe '/' do
        it 'renders the README' do
          get '/'
          last_response.headers['Content-Type'].should match %r[text/html]
          last_response.body.should match 'Serve up fake receipt and offer information for API testing'
        end
      end

      describe 'assets' do
        [%w[css text/css], %w[js application/javascript]].each do |ext, mime|
          route = "/application.#{ext}"
          describe route do
            it "renders the results as #{mime}" do
              get route
              last_response.headers['Content-Type'].should match %r[#{mime}]
            end
          end
        end
      end

      %w[sync receipts offers].each do |action|
        route = "/#{action}"
        describe route do
          it 'renders the results as JSON' do
            get route
            last_response.headers['Content-Type'].should match %r[application/json]
          end
        end
      end

      describe 'the limit parameter' do
        it 'specifies the number of results to be returned' do
          get '/receipts', 'limit' => '37' do
            JSON.parse(last_response.body)['receipts'].length.should be 37
          end
        end
      end
    end

    describe 'POST' do

      describe '/registration' do
        it 'fails if you pass a fail parameter' do
          post '/registration', 'fail' => 'yes'
          last_response.status.should be 400
          last_response.headers['Content-Type'].should match %r[application/json]
        end

        it 'succeeds if you pass in anything else' do
          post '/registration', 'wooly' => 'willy'
          last_response.status.should be 200
          last_response.headers['Content-Type'].should match %r[application/json]
        end

        it 'succeeds if you pass in nothing' do
          post '/registration'
          last_response.status.should be 200
          last_response.headers['Content-Type'].should match %r[application/json]
        end
      end

      describe '/receipts/add' do

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
