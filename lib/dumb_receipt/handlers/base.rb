require 'sinatra/base'
require 'dumb_receipt/data'
require 'dumb_receipt/handlers/helpers'
require 'json'

module DumbReceipt
  module Handlers
    class Base < Sinatra::Base
      include DumbReceipt::Data
      include DumbReceipt::Handlers::Helpers

      before do
        content_type :json
      end
    end
  end
end
