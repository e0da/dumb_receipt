require 'dumb_receipt/data'

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
    end
  end
end
