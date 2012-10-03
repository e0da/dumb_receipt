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

    get '/' do
      markdown :README, layout_engine: :slim
    end

    get '/application.css' do
      sass :application
    end

    get '/application.js' do
      coffee :application
    end

    get '/sync.json' do
      YAML.load_file('lib/dumb_receipt/views/sample_data.yml').to_json
    end
  end
end
