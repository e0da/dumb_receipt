require 'sinatra/base'
require 'dumb_receipt/data'
require 'dumb_receipt/handlers/helpers'

module DumbReceipt
  module Handlers
    class Base < Sinatra::Base
      include DumbReceipt::Data
      include DumbReceipt::Handlers::Helpers
    end
  end
end
