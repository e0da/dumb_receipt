require 'spec_helper'
require 'dumb_receipt/handlers/location'

module DumbReceipt
  module Handlers
    describe Location do
      include Rack::Test::Methods

      def app
        DumbReceipt::Handlers::Location
      end

      describe 'GET /location/:id' do

        it 'returns the location' do
          get '/location/some-fake-id'
          response_data['location'].should == data['locations'][0]
        end

         it 'fails if you pass a fail parameter' do
           get '/location/some-fake-id', 'fail' => 'yes'
           status.should be 404
           error['type'].should == 'LocationNotFound'
           error['message'].should == 'We could not find the location matching the given id.'
         end
      end
    end
  end
end
