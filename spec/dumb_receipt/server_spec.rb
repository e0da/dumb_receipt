require 'spec_helper'

require 'dumb_receipt/server'
require 'json'

describe DumbReceipt::Server do

  describe 'routes' do
    include Rack::Test::Methods

    describe 'GET /' do
      it 'renders the README' do
        get '/'
        last_response.headers['Content-Type'].should match %r[text/html]
        last_response.body.should match 'Serve up fake receipt and offer information for API testing'
      end
    end

    describe 'assets' do
      [%w[css text/css], %w[js application/javascript]].each do |ext, mime|
        route = "/application.#{ext}"
        describe "GET #{route}" do
          it "renders the results as #{mime}" do
            get route
            last_response.headers['Content-Type'].should match %r[#{mime}]
          end
        end
      end
    end
  end
end
