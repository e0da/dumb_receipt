require 'spec_helper'
require 'dumb_receipt/handlers/pages'

module DumbReceipt
  module Handlers
    describe Pages do

      pp Pages.views

      it 'inherits DumbReceipt::Handlers::Base' do
        Pages.ancestors.should include DumbReceipt::Handlers::Base
      end

      describe 'GET /visualize' do
        it 'renders the data visualization page' do
          get '/visualize'
          content_type.should match %r[text/html]
          status.should be 200
          body.should match '<title>DumbReceipt - Visualize Data</title>'
        end
      end

      describe 'GET /' do
        it 'renders the README' do
          get '/'
          status.should be 200
          content_type.should match %r[text/html]
          body.should match '<title>DumbReceipt - README</title>'
        end
      end

      %w[application visualize].each do |script|
        describe "GET /#{script}.js" do
          it 'renders the results as application/javascript' do
            get "/#{script}.js"
            status.should be 200
            content_type.should match %r[application/javascript]
          end
        end
      end

      describe 'GET /application.css' do
        it 'renders the results as text/css' do
          get '/application.css'
          status.should be 200
          content_type.should match %r[text/css]
        end
      end
    end
  end
end
