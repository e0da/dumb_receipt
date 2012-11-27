require 'dumb_receipt/handlers/base'

module DumbReceipt
  module Handlers
    class Location < DumbReceipt::Handlers::Base

      get '/location/:id' do
        location_result
      end

      private

      def location_result
        if params[:fail]
          [404, failure('get', 'location_not_found')]
        else
          { location: data['locations'][0] }.to_json
        end
      end
    end
  end
end
