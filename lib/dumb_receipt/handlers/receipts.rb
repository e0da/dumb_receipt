require 'dumb_receipt/handlers/base'
require 'json'

module DumbReceipt
  module Handlers
    class Receipts < DumbReceipt::Handlers::Base

      get '/receipts' do
        content_type :json
        {receipts: results_for('receipts')}.to_json
      end

      post '/receipts/add' do
        content_type :json

        case params[:fail]

        when 'ReceiptAlreadyAssociated'
          [403, failure('receipt_already_associated').to_json]

        when 'ReceiptNotFound'
          [404, failure('receipt_not_found').to_json]

        else
          {
            receipt:  data['receipts'][0],
            offers:   data['offers'][0..1],
            location: data['locations'][0],
          }.to_json
        end
      end

      private

      def failure(id)
        data['responses']['receipts']['add']['failures'][id]
      end
    end
  end
end
