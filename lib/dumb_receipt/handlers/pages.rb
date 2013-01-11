require 'dumb_receipt/handlers/base'

require 'redcarpet'
require 'slim'
require 'sass'
require 'coffee-script'

module DumbReceipt
  module Handlers
    class Pages < Base

      %w[application visualize].each do |script|
        get("/#{script}.js") { coffee script.to_sym }
      end

      get('/application.css') { sass :application }

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
