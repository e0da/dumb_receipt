require 'spec_helper'
require 'dumb_receipt/handlers/base'

module DumbReceipt
  module Handlers
    describe Base do

      it 'includes DumbReceipt::Data' do
        Base.should include DumbReceipt::Data
      end

      it 'includes DumbReceipt::Handlers::Helpers' do
        Base.should include DumbReceipt::Handlers::Helpers
      end
    end
  end
end
