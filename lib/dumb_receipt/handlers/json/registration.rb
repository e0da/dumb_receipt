require 'dumb_receipt/handlers/json/base'

module DumbReceipt
  module Handlers
    module JSON
      class Registration < Base

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
end
