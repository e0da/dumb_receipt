require 'dumb_receipt/handlers/base'

module DumbReceipt
  module Handlers
    class Registration < DumbReceipt::Handlers::Base

      post '/registration' do
        content_type :json
        if params[:fail]
          [400, result('failure')]
        else
          result('success')
        end
      end

      private

      def result(id)
        data['responses']['registration'][id].to_json
      end
    end
  end
end
