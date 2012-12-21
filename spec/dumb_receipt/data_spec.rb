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
          dummy = dummy_class_factory.new
          dummy.should_receive(:load_yaml_erb).and_return 'FOO' => 'BAR'
          dummy.send(method)['FOO'].should == 'BAR'
        end

        it 'only loads the YAML file once for all classes and instances' do

          # FIXME: It would be nice to bind this less tightly to its internal
          # dependency, but I haven't yet thought of a better way to test that a
          # bunch of classes only call an included method from a module one
          # time.
          #
          JSON.should_receive(:parse).once.and_return({})
          100.times { dummy_class_factory.new.send method }
        end
      end
    end

    describe '#load_yaml_erb' do

      it 'parses a .yaml.erb file' do
        File.should_receive(:open).and_return %[---\nFOO: <%= "BAR" %>]
        dummy_class_factory.new.send(:load_yaml_erb, nil)['FOO'].should == 'BAR'
      end
    end
  end
end
