require 'spec_helper'
require 'dumb_receipt/app'

module DumbReceipt
  describe App do

    def middleware
      @middleware ||= App.instance_variable_get(:@middleware).flatten
    end

    %w[
      Images
      Pages
      JSON::Offers
      JSON::Receipts
      JSON::Registration
      JSON::Stats
      JSON::Sync
    ].each do |klass|
      klass = eval "DumbReceipt::Handlers::#{klass}"
      it "should include middleware #{klass}" do
        middleware.should include klass
      end
    end
  end
end
