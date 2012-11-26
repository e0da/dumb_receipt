require 'spec_helper'
require 'dumb_receipt/data'

module DumbReceipt
  describe DumbReceipt::Data do

    def dummy_class_factory
      Class.new do
        include DumbReceipt::Data
      end
    end

    def unload_data
      DumbReceipt::Data.instance_variable_set :@data, nil
    end

    describe '#data' do

      it 'calls .data' do
        DumbReceipt::Data.should_receive(:data)
        dummy_class_factory.new.data
      end
    end

    describe '.data' do

      around :each do |example|

        # Prevent contamination of other specs by resetting data
        #
        unload_data
        example.run
        unload_data
      end

      it 'loads the data' do
        YAML.should_receive(:load_file)
        dummy_class_factory.new.data
      end

      it 'only loads the YAML file once for all classes and instances' do
        YAML.should_receive(:load_file).once.and_return({})
        100.times { dummy_class_factory.new.data }
      end
    end
  end
end
