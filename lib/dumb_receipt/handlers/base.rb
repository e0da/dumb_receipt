require 'sinatra/base'
require 'dumb_receipt/data'
require 'dumb_receipt/handlers/helpers'

module DumbReceipt
  module Handlers
    class Base < Sinatra::Base
      include DumbReceipt::Data
      include DumbReceipt::Handlers::Helpers

      set :root, File.expand_path('../../../../..', __FILE__)
      before do
        content_type :json
      end
    end
  end
end
