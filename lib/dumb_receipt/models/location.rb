require 'dumb_receipt/models/model'

module DumbReceipt
  module Models
    class Location < Model
      set_accessors %w[
        uuid
        name
        brand
        address1
        address2
        city
        state
        zip
        country
        logo_url
      ]
    end
  end
end
