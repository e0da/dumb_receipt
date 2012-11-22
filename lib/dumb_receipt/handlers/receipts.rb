require 'dumb_receipt/handlers/base'

module DumbReceipt
  module Handlers
    class Receipts < DumbReceipt::Handlers::Base

      get '/receipts' do
        content_type :json
        {receipts: results_for('receipts')}.to_json
      end

      post '/receipts/add' do
        content_type :json
        add_result
      end

      delete '/receipts/:id' do
        content_type :json
        delete_result
      end

      private

      def failure(action, type)
        data['responses']['receipts'][action]['failures'][type].to_json
      end

      def add_result
        case params[:fail]
        when 'ReceiptAlreadyAssociated'
          [403, failure('add', 'receipt_already_associated')]
        when 'ReceiptNotFound'
          [404, failure('add', 'receipt_not_found')]
        else
          {
            receipt:  data['receipts'][0],
            offers:   data['offers'][0..1],
            location: data['locations'][0],
          }.to_json
        end
      end

      def delete_result
        if params[:fail]
          [400, failure('delete', 'receipt_not_deleted')]
        else
          [200, nil]
        end
      end
    end
  end
end
