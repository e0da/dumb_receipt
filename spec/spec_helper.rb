begin
  require 'simplecov'
  SimpleCov.configure { add_filter 'spec' }
  SimpleCov.start
rescue LoadError
  # No coverage then. Moving on...
end

require 'dumb_receipt/data'
require 'rack/test'

include DumbReceipt::Data

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.include Rack::Test::Methods

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

def error
  JSON.parse(last_response.body)['error']
end
