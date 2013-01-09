require 'dumb_receipt/handlers/base'

module DumbReceipt
  module Handlers
    class JsonBase < Base
      before do
        content_type :json
      end
    end
  end
end
