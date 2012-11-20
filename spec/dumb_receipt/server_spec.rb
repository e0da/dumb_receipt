require 'spec_helper'

require 'dumb_receipt/server'

describe DumbReceipt::Server do
  describe 'GET /', type: :feature do
    it 'renders the README' do
      visit '/'
      page.should have_content 'Serve up fake receipt and offer information for API testing'
    end
  end
end
