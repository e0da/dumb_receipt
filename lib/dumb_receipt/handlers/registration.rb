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
        data['responses']['registration'][id].to_json
      end
    end
  end
end
