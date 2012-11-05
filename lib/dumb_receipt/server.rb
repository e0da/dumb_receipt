require 'dumb_receipt'
require 'sinatra'
require 'redcarpet'
require 'slim'
require 'sass'
require 'coffee-script'
require 'yaml'
require 'json'

module DumbReceipt
  class Server < Sinatra::Base

    # this is supposed to be the default, but the implicit setting isn't
    # working with rackup, so here it is explicitly.
    set :public_folder, 'public'

    # README requests
    get('/')                { markdown :README, layout_engine: :slim }
    get('/application.css') { sass     :application }
    get('/application.js')  { coffee   :application }

    # JSON requests (the meat)
    %w[sync receipts offers].each do |type|
      get("/#{type}.json") do
        content_type :json
        YAML.load_file('lib/dumb_receipt/views/sample_data.yml')[type].to_json
      end
    end

    # "registration"
    #
    # If the client sets a parameter called 'fail', fail authentication.
    # Otherwise, succeed. This has no effect on the client's ability to access
    # data; it's just a mechanism for testing registration behavior in clients.
    #
    post '/registration' do
      if params[:fail]
        [400, DumbReceipt::JSON::AUTH_FAILURE]
      else
        DumbReceipt::JSON::AUTH_SUCCESS
      end
    end
  end
end
