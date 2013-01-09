require 'dumb_receipt/handlers/base'

module DumbReceipt
  module Handlers
    module JSON
      class Base < DumbReceipt::Handlers::Base
        before do
          content_type :json
        end
      end
    end
  end
end
