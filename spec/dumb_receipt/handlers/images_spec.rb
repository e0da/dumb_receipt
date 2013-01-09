require 'spec_helper'
require 'dumb_receipt/handlers/images'
require 'net/http'

module DumbReceipt
  module Handlers
    describe Images do

      IMAGE_NAME = 'bettys_diner.png'
      IMAGE_TYPE = IMAGE_NAME.split('.')[-1].downcase

      it 'inherits DumbReceipt::Handlers::Base' do
        Images.ancestors.should include DumbReceipt::Handlers::Base
      end

      it 'serves an image if the file exists' do

        image_size = File.new("#{Images.root}/public/images/#{IMAGE_NAME}").size

        get "/images/#{IMAGE_NAME}"
        last_response.headers['Content-Type'].should == "image/#{IMAGE_TYPE}"
        last_response.headers['Content-Length'].to_i.should be image_size
      end

      it "serves a dummy image if the path doesn't exist" do
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
