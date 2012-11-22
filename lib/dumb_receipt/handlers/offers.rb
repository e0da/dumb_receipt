require 'dumb_receipt/handlers/base'

module DumbReceipt
  module Handlers
    class Offers < DumbReceipt::Handlers::Base

      get '/offers' do
        content_type :json
        {offers: results_for('offers')}.to_json
      end

      post '/offers/read' do
        content_type :json
        read_result
      end

      post '/offers/redeem' do
        content_type :json
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
