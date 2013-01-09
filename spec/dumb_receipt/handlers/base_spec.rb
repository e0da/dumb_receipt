require 'spec_helper'
require 'dumb_receipt/handlers/base'

module DumbReceipt
  module Handlers
    describe Base do
      include Rack::Test::Methods

      it 'includes DumbReceipt::Handlers::Helpers' do
        Base.should include DumbReceipt::Handlers::Helpers
      end

      it 'correctly sets the app root path' do
        Base.root.should == File.expand_path('../../../../', __FILE__)
      end
    end
  end
end
