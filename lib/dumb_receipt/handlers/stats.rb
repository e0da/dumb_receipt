require 'dumb_receipt/handlers/json_base'

module DumbReceipt
  module Handlers
    class Stats < JsonBase

      get '/stats' do
        json({
          :stats => data['stats']
        })
      end
    end
  end
end

