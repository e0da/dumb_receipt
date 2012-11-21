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
        result
      end

      private

      def failure(id)
        data['responses']['receipts']['add']['failures'][id].to_json
      end

      def result
        case params[:fail]
        when 'ReceiptAlreadyAssociated'
          [403, failure('receipt_already_associated')]
        when 'ReceiptNotFound'
          [404, failure('receipt_not_found')]
        else
          {
            receipt:  data['receipts'][0],
            offers:   data['offers'][0..1],
            location: data['locations'][0],
          }.to_json
        end
      end
    end
  end
end
