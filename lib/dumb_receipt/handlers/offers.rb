require 'dumb_receipt/handlers/base'
require 'json'

module DumbReceipt
  module Handlers
    class Offers < DumbReceipt::Handlers::Base

      get '/offers' do
        content_type :json
        {offers: results_for('offers')}.to_json
      end
    end
  end
end
