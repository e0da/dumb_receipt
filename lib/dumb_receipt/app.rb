require 'sinatra/base'

require 'dumb_receipt/logging'
require 'dumb_receipt/handlers/images'
require 'dumb_receipt/handlers/pages'
require 'dumb_receipt/handlers/json/offers'
require 'dumb_receipt/handlers/json/receipts'
require 'dumb_receipt/handlers/json/registration'
require 'dumb_receipt/handlers/json/stats'
require 'dumb_receipt/handlers/json/sync'

module DumbReceipt
  class App < Sinatra::Base

    use DumbReceipt::Logging

    use DumbReceipt::Handlers::Images
    use DumbReceipt::Handlers::Pages

    use DumbReceipt::Handlers::JSON::Offers
    use DumbReceipt::Handlers::JSON::Receipts
    use DumbReceipt::Handlers::JSON::Registration
    use DumbReceipt::Handlers::JSON::Stats
    use DumbReceipt::Handlers::JSON::Sync
  end
end
