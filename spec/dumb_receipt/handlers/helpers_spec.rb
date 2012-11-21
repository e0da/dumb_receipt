require 'spec_helper'
require 'dumb_receipt/handlers/helpers'

module DumbReceipt
  module Handlers
    describe Helpers do

      let :dummy_class do
        Class.new do
          include DumbReceipt::Handlers::Helpers
        end
      end

      it 'includes DumbReceipt::Data' do
        Helpers.should include DumbReceipt::Data
      end

      describe '#results_for' do

        it 'gets the specified results from the data' do
          dummy_class.any_instance.stub(:params).and_return({})
          dummy_class.new.results_for('receipts').length.should == data['receipts'].length
        end

        it 'pads the results according to the specified limit' do
          dummy_class.any_instance.stub(:params).and_return({limit: '37'})
          dummy_class.new.results_for('receipts').length.should == 37
        end
      end

      describe '#pad' do
        it 'pads the given results to the given limit' do
          dummy_class.new.pad(data['receipts'], 42).length.should == 42
        end
      end
    end
  end
end