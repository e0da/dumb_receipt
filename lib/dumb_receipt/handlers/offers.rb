require 'dumb_receipt/handlers/json_base'

module DumbReceipt
  module Handlers
    class Offers < DumbReceipt::Handlers::JsonBase

      get '/offers' do
        {offers: results_for('offers')}.to_json
      end

      post '/offers/read' do
        read_result
      end

      post '/offers/redeem' do
        redeem_result
      end

      private

      def read_result
        if params[:fail]
          [400, failure('read', 'offers_not_marked_as_read')]
        else
          [200]
        end
      end

      def redeem_result
        if params[:fail]
          [400, failure('redeem', 'offer_not_redeemed')]
        else
          { offer: data['offers'][0] }.to_json
        end
      end
    end
  end
end
