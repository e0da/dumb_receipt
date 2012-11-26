require 'spec_helper'
require 'dumb_receipt/data'

module DumbReceipt
  describe DumbReceipt::Data do

    let :dummy_class do
      Class.new do
        include DumbReceipt::Data
      end
    end

    around :each do |example|

      # Prevent contamination of other specs by resetting data
      #
      unload_data
      example.run
      unload_data
    end

    describe '#data' do

      it 'calls .data' do
        DumbReceipt::Data.should_receive(:data)
        dummy_class.new.data
      end
    end

    describe '.data' do

      it 'loads the data' do
        YAML.should_receive(:load_file)
        dummy_class.new.data
      end

      it 'only loads the YAML file once' do
        YAML.should_receive(:load_file).once.and_return({})
        100.times { dummy_class.new.data }
      end
    end
  end
end
