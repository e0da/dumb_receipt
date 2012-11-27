require 'sinatra/base'
require 'dumb_receipt/handlers/base'
require 'json'

module DumbReceipt
  module Handlers
    class JsonBase < DumbReceipt::Handlers::Base
      before do
        content_type :json
      end
    end
  end
end
