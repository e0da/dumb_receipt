require 'dumb_receipt/data'
require 'json'

module DumbReceipt
  module Handlers
    module Helpers
      include DumbReceipt::Data

      def results_for(type)
        results = data[type]
        results = pad(results, params[:limit].to_i) if params[:limit]
        results
      end

      # pad the results to the specified length by duplicating and/or slicing them
      #
      def pad(results, limit)
        multiplier = [(limit / results.length).ceil, limit].max
        (results * multiplier)[0...limit]
      end

      def failure(action, type)
        data['responses'][base_class_name.downcase][action]['failures'][type].to_json
      end

      def base_class_name
        self.class.name.split('::')[-1]
      end
    end
  end
end
