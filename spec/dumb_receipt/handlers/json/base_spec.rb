require 'spec_helper'
require 'dumb_receipt/handlers/json/base'

module DumbReceipt
  module Handlers
    module JSON
      describe Base do
        include Rack::Test::Methods

        it 'extends DumbReceipt::Handlers::Base' do
          Base.ancestors.should include DumbReceipt::Handlers::Base
        end

        it 'sets Content-Type to application/json' do
          class Dummy < Base
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
end
