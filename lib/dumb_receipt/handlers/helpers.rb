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
        json responses[base_class_name.downcase][action]['failures'][type]
      end

      def base_class_name
        self.class.name.split('::')[-1]
      end

      def json(object)
        JSON.pretty_generate JSON.parse(object.to_json)
      end
    end
  end
end
