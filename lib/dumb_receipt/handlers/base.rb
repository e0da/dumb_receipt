require 'dumb_receipt/handlers/helpers'
require 'sinatra/base'

module DumbReceipt
  module Handlers
    class Base < Sinatra::Base
      include DumbReceipt::Handlers::Helpers
      set :root, File.expand_path('../../../..', __FILE__)
    end
  end
end
