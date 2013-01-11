require 'dumb_receipt/handlers/base'

require 'redcarpet'
require 'slim'
require 'sass'
require 'coffee-script'

module DumbReceipt
  module Handlers
    class Pages < Base
      get('/application.css') { sass     :application }
      get('/application.js')  { coffee   :application }

      get '/' do
        @title = 'README'
        markdown :README,    layout_engine: :slim
      end

      get '/visualize' do
        @title = 'Visualize Data'
        slim     :visualize
      end
    end
  end
end
