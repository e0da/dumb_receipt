require 'spec_helper'
require 'dumb_receipt/handlers/base'

module DumbReceipt
  module Handlers
    describe Base do
      include Rack::Test::Methods

      it 'includes DumbReceipt::Data' do
        Base.should include DumbReceipt::Data
      end

      it 'includes DumbReceipt::Handlers::Helpers' do
        Base.should include DumbReceipt::Handlers::Helpers
      end

      it 'sets Content-Type to application/json' do
        class Dummy < DumbReceipt::Handlers::Base
          get('/dummy') {'null'}
        end

        def app
          Dummy
        end

        get '/dummy'
        content_type.should match %r[application/json]
      end
    end
  end
end
