require 'dumb_receipt/handlers/base'

module DumbReceipt
  module Handlers
    class Readme < Base
      get('/')                { markdown :README, layout_engine: :slim }
      get('/application.css') { sass     :application }
      get('/application.js')  { coffee   :application }
    end
  end
end
