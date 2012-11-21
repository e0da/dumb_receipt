require 'sinatra/base'
require 'dumb_receipt/data'

module DumbReceipt
  module Handlers
    class Base < Sinatra::Base
      include DumbReceipt::Data

      def results_for(type)
        results = data[type]
        results = pad(results) if limit
        results
      end

      def limit
        params[:limit] and params[:limit].to_i
      end

      # pad the results to the specified length by duplicating and/or slicing them
      #
      def pad(results)
        multiplier = [(limit / results.length).ceil, limit].max
        (results * multiplier)[0...limit]
      end
    end
  end
end
