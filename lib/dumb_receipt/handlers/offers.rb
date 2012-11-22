require 'dumb_receipt/handlers/base'

module DumbReceipt
  module Handlers
    class Offers < DumbReceipt::Handlers::Base

      get '/offers' do
        content_type :json
        {offers: results_for('offers')}.to_json
      end

      post '/offers/read' do
        if params[:fail]
          [400, failure('read', 'offers_not_redeemed')]
        else
          [200]
        end
      end
    end
  end
end
