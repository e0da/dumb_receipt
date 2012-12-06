require 'spec_helper'
require 'dumb_receipt/handlers/stats'

module DumbReceipt
  module Handlers
    describe Stats do
      include Rack::Test::Methods

      def app
        DumbReceipt::Handlers::Stats
      end

      it 'inherits DumbReceipt::Handlers::Base' do
        Stats.ancestors.should include DumbReceipt::Handlers::Base
      end

      describe 'GET /stats' do
        it 'returns the stats' do
          get '/stats'
          response_data['stats'].should == data['stats']
        end
      end
    end
  end
end

