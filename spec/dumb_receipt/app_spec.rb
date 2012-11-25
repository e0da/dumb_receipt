require 'spec_helper'
require 'dumb_receipt/app'

describe DumbReceipt::App do

  describe 'routes' do
    include Rack::Test::Methods

    def app
      DumbReceipt::App
    end

    describe 'GET /' do
      it 'renders the README' do
        get '/'
        content_type.should match %r[text/html]
        body.should match 'Serve up fake receipt and offer information for API testing'
      end
    end

    describe 'assets' do

      describe 'GET /application.js' do
        it 'renders the results as application/javascript' do
          get '/application.js'
          content_type.should match %r[application/javascript]
        end
      end

      describe 'GET /application.css' do
        it 'renders the results as text/css' do
          get '/application.css'
          content_type.should match %r[text/css]
        end
      end
    end
  end
end
