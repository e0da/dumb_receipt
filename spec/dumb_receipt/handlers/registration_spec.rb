require 'spec_helper'
require 'dumb_receipt/handlers/registration'

module DumbReceipt
  module Handlers
    describe Registration do
      include Rack::Test::Methods


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
      end
    end
  end
end
