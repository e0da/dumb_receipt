require 'dumb_receipt/handlers/base'

module DumbReceipt
  module Handlers
    class Stats < DumbReceipt::Handlers::Base

      get '/stats' do
        json({
          :stats => data['stats']
        })
      end
    end
  end
end

