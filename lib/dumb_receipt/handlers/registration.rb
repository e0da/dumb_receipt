require 'dumb_receipt/handlers/base'
require 'json'

module DumbReceipt
  module Handlers
    class Registration < DumbReceipt::Handlers::Base

      # "registration"
      #
      # If the client sets a parameter called 'fail', fail authentication.
      # Otherwise, succeed. This has no effect on the client's ability to access
      # data; it's just a mechanism for testing registration behavior in clients.
      #
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
