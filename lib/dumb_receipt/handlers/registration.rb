require 'dumb_receipt/handlers/json_base'

module DumbReceipt
  module Handlers
    class Registration < DumbReceipt::Handlers::JsonBase

      post '/registration' do
        if params[:fail]
          [400, result('failure')]
        else
          result('success')
        end
      end

      private

      def result(id)
        json data['responses']['registration'][id]
      end
    end
  end
end
