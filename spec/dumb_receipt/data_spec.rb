require 'spec_helper'
require 'dumb_receipt/data'

module DumbReceipt
  describe DumbReceipt::Data do

    def dummy_class_factory
      Class.new do
        include DumbReceipt::Data
      end
    end

    def unload(method)
      DumbReceipt::Data.class_variable_set "@@#{method}".to_s, nil
    end

    [:data, :responses].each do |method|

      describe "##{method}" do

        around :each do |example|

          # Prevent contamination of other specs by resetting data
          #
          unload method
          example.run
          unload method
        end

        it 'loads the data' do
          JSON.should_receive(:parse)
          YAML.should_receive(:load_file)
          dummy_class_factory.new.send method
        end

        it 'only loads the YAML file once for all classes and instances' do
          YAML.should_receive(:load_file).once.and_return({})
          100.times { dummy_class_factory.new.send method }
        end
      end
    end
  end
end
