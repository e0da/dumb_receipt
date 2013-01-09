require 'dumb_receipt/handlers/json/base'

module DumbReceipt
  module Handlers
    module JSON
      class Stats < Base

        get '/stats' do
          json({
            :stats => data['stats']
          })
        end
      end
    end
  end
end
