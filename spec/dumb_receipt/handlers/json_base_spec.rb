require 'spec_helper'
require 'dumb_receipt/handlers/json_base'

module DumbReceipt
  module Handlers
    describe JsonBase do

      it 'inherits DumbReceipt::Handlers::Base' do
        JsonBase.ancestors.should include DumbReceipt::Handlers::Base
      end

      it 'sets Content-Type to application/json' do
        class Dummy < DumbReceipt::Handlers::JsonBase
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
