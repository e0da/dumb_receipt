require 'dumb_receipt/models/model'

module DumbReceipt
  module Models
    class Item < Model
      set_accessors :name, :price, :quantity
    end
  end
end
