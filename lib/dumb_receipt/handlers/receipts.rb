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

      post '/receipts/email' do
        content_type :json
        email_result
      end

      delete '/receipts/:id' do
        content_type :json
        delete_result
      end

      private

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

      def email_result
        case params[:fail]
        when 'ReceiptNotFound'
          [404, failure('email', 'receipt_not_found')]
        when 'InvalidEmailOrMissingReceiptUUID'
          [400, failure('email', 'invalid_email_or_missing_receipt_uuid')]
        else
          [200]
        end
      end

      def delete_result
        if params[:fail]
          [400, failure('delete', 'receipt_not_deleted')]
        else
          [200]
        end
      end
    end
  end
end
