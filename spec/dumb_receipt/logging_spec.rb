require 'spec_helper'
require 'sinatra/base'
require 'dumb_receipt/logging'

module DumbReceipt
  describe Logging do

    let :app do
      Class.new Sinatra::Base do
        use Logging
        get('/') { 'OHAI' }
      end
    end

    it 'logs requests made by an app' do
      Logging.any_instance.should_receive(:log).once.and_call_original
      get '/'
    end
  end
end
