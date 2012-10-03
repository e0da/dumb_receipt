$: << 'lib'

require 'dumb_receipt'

map '/public' do
  run Rack::Directory.new './public'
end

run DumbReceipt::Server.new
