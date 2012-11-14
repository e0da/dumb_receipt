module DumbReceipt
  module Models
    class Model

      protected

      #
      # Accept a list of attributes as an array of strings
      # or symbols and set attr_accessor for each of them
      #
      def self.set_accessors(*attributes)
        attr_accessor *attributes.flatten.map {|s| s.to_sym}
      end
    end
  end
end
