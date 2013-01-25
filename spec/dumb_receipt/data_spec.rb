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
          # implementation (JSON.parse), but I haven't yet thought of a better
          # way to test that a bunch of classes only call an included method
          # from a module one time.
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

      it 'sets the @root_url for templates if this is a request' do
        File.should_receive(:open).and_return %[---\nFOO: <%= @root_url %>]
        dummy_url = 'http://dummy_url/'
        dummy_class_factory.new.tap do |dummy|
          dummy.define_singleton_method :request do
            OpenStruct.new env: { 'REQUEST_URI' => dummy_url }
          end
        end.send(:load_yaml_erb, nil)['FOO'].should == dummy_url
      end

      it 'uses a default value if this is not a request' do
        File.should_receive(:open).and_return %[---\nFOO: <%= @root_url %>]
        dummy_class_factory.new.send(:load_yaml_erb, nil)['FOO'].should == 'fake_root_url'
      end
    end
  end
end
