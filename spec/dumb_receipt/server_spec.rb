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
        it 'fails if you pass a fail attribute' do
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

    end
  end
end
