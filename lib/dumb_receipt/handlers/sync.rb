require 'dumb_receipt/handlers/json_base'
require 'time'

module DumbReceipt
  module Handlers
    class Sync < DumbReceipt::Handlers::JsonBase

      get '/sync' do
        json({
          sync_timestamp: Time.now.utc.iso8601,
          user:           results_for('users')[0],
          offers:         results_for('offers'),
          receipts:       results_for('receipts'),
          locations:      results_for('locations')
        })
      end
    end
  end
end
