require 'spec_helper'

require 'dumb_receipt/server'

describe DumbReceipt::Server do

  describe 'GET /', type: :feature do
    it 'renders the README' do
      visit '/'
      page.should have_content 'Serve up fake receipt and offer information for API testing'
    end
  end

  describe 'GET /application.css', type: :feature do
    it 'renders the stylesheet' do
      visit '/application.css'
      response_headers['Content-Type'].should =~ %r[text/css]
    end
  end

  describe 'GET /application.js', type: :feature do
    it 'renders the javascript' do
      visit '/application.js'
      response_headers['Content-Type'].should =~ %r[application/javascript]
    end
  end

  describe 'GET /receipts', type: :feature do
    it 'renders the results as JSON' do
      visit '/receipts'
      response_headers['Content-Type'].should =~ %r[application/json]
    end
  end
end
