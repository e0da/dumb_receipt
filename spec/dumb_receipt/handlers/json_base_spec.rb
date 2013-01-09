require 'spec_helper'
require 'dumb_receipt/handlers/json_base'

module DumbReceipt
  module Handlers
    describe JsonBase do
      include Rack::Test::Methods

      it 'extends DumbReceipt::Handlers::Base' do
        Base.ancestors.should include DumbReceipt::Handlers::Base
      end

      it 'sets Content-Type to application/json' do
        class Dummy < JsonBase
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
