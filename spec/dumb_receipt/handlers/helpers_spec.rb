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

      describe '#failure' do

        it 'selects the data from the current class for the given action and type' do
          dummy_class.any_instance.stub(:base_class_name).and_return('receipts')
          dummy_class.new.failure('add', 'receipt_not_found').should \
            == data['responses']['receipts']['add']['failures']['receipt_not_found'].to_json
        end
      end

      describe '#base_class_name' do

        it 'gives the current class name with no modules' do
          dummy_class.any_instance.stub(:class).and_return(DumbReceipt::Data)
          dummy_class.new.base_class_name.should == 'Data'
        end

        it 'works with an already base class name' do
          dummy_class.any_instance.stub(:class).and_return(Kernel)
          dummy_class.new.base_class_name.should == 'Kernel'
        end
      end
    end
  end
end
