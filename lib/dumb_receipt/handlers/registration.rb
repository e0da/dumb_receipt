require 'dumb_receipt/handlers/base'

module DumbReceipt
  module Handlers
    class Registration < DumbReceipt::Handlers::Base

      post '/registration' do
        if params[:fail]
          [400, result('failure')]
        else
          result('success')
        end
      end

      private

      def result(id)
        json responses['registration'][id]
      end
    end
  end
end
