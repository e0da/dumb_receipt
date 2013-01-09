require 'dumb_receipt/handlers/json/base'

module DumbReceipt
  module Handlers
    module JSON
      class Sync < Base

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
end
