require 'sinatra/base'
require 'redcarpet'
require 'slim'
require 'sass'
require 'coffee-script'

require 'dumb_receipt/handlers/offers'
require 'dumb_receipt/handlers/receipts'
require 'dumb_receipt/handlers/registration'
require 'dumb_receipt/handlers/sync'

module DumbReceipt
  class App < Sinatra::Base

    # the implicit setting isn't working with rackup
    set :public_folder, 'public'

    get('/')                { markdown :README, layout_engine: :slim }
    get('/application.css') { sass     :application }
    get('/application.js')  { coffee   :application }

    use DumbReceipt::Handlers::Offers
    use DumbReceipt::Handlers::Receipts
    use DumbReceipt::Handlers::Registration
    use DumbReceipt::Handlers::Sync
  end
end