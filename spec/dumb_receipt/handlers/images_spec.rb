require 'spec_helper'
require 'dumb_receipt/handlers/images'

module DumbReceipt
  module Handlers
    describe Images do

      def app
        DumbReceipt::Handlers::Images
      end

      it 'serves a dummy image' do
        get '/images/whatever.png'
        content_type.should match 'image/png'
      end

      it 'gives a 404 if you specify a fail parameter' do
        get '/images/derp.jpg', 'fail' => 'yes'
        status.should be 404
      end
    end
  end
end
