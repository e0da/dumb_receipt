require 'simplecov'
SimpleCov.configure { add_filter 'spec' }
SimpleCov.start

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

def response
  JSON.parse(last_response.body)
end

def error
  response['error']
end

def status
  last_response.status
end

def content_type
  last_response.header['Content-Type']
end

def body
  last_response.body
end

##
# Returns the RSpec subject which will be the middleware or app that is being
# spec-ed when Rack::Test::Methods methods call `app`.
#
def app
  subject # inherited from RSpec::Core::Subject::ExampleMethods
end


class Array

  ##
  # Returns true if the array has duplicates and false if it does not.
  #
  def has_duplicates?
    self.length != self.uniq.length
  end
end
