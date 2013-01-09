require 'dumb_receipt/data'
require 'json'

module DumbReceipt
  module Handlers
    module Helpers
      include DumbReceipt::Data

      ##
      # Returns results for the given data type padded to the limit specified by
      # params[:limit]
      #
      # ## Example ##
      #
      #     results_for(receipts)   #   {"receipts": [ {"uuid": "..."}, ... ] }
      #
      def results_for(type)
        results = data[type]
        results = pad(results, params[:limit].to_i) if params[:limit]
        results
      end

      ##
      # Pads the results to the specified length by duplicating and/or slicing them
      #
      def pad(results, limit)
        multiplier = [(limit / results.length).ceil, limit].max
        (results * multiplier)[0...limit]
      end

      ##
      # Returns the given failure object from responses for the current class
      #
      # ## Example ##
      #
      #     class Receipts
      #       failure('add', 'not_found')   #   value of responses.yml:receipts/add/failures/not_found
      #     end
      #
      def failure(action, type)
        json responses[base_class_name.downcase][action]['failures'][type]
      end

      ##
      # Returns the base class name of the current object
      #
      # ## Example ##
      #
      # module DumbReceipt
      #   class FakeClass
      #     base_class_name   #   "FakeClass" and not "DumbReceipt::FakeClass"
      #   end
      # end
      #
      def base_class_name
        self.class.name.split('::')[-1]
      end

      ##
      # Returns formatted JSON output for the given object.
      #
      def json(object)
        ::JSON.pretty_generate object
      end
    end
  end
end
