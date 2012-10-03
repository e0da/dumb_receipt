require 'sinatra'
require 'redcarpet'
require 'slim'
require 'sass'
require 'coffee-script'
require 'yaml'
require 'json'

module DumbReceipt
  class Server < Sinatra::Base
    get '/' do
      readme
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

    private

    def readme
      markdown :README, layout_engine: :slim
    end
  end
end
