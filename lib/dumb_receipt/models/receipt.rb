require 'dumb_receipt/models/model'

module DumbReceipt
  module Models
    class Receipt < Model
      set_accessors %w[
        uuid
        currency
        claimed_at
        completed_at
        item_count
        total
        items
        zones
        offers
        location
      ]
    end
  end
end
