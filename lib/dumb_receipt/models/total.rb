require 'dumb_receipt/models/model'

module DumbReceipt
  module Models
    class Total < Model
      attr_accessor :total, :tax, :subtotal
    end
  end
end
