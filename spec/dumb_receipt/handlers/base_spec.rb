require 'spec_helper'
require 'dumb_receipt/handlers/base'

module DumbReceipt
  module Handlers
    describe Base do
      include Rack::Test::Methods

      let :dummy_class do
        Class.new(Base) { get('/') { 'OHAI' } }
      end

      def app
        dummy_class
      end

      it 'includes DumbReceipt::Handlers::Helpers' do
        Base.should include DumbReceipt::Handlers::Helpers
      end

      it 'correctly sets the app root path' do
        Base.root.should == File.expand_path('../../../../', __FILE__)
      end
    end
  end
end
