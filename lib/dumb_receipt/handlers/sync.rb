require 'dumb_receipt/handlers/json_base'

module DumbReceipt
  module Handlers
    class Sync < JsonBase

      get '/sync' do
        json({
          sync_timestamp: Time.now.utc,
          user:           results_for('users')[0],
          offers:         results_for('offers'),
          receipts:       results_for('receipts'),
          locations:      results_for('locations')
        })
      end
    end
  end
end
