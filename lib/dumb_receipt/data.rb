require 'yaml'

module DumbReceipt
  module Data

    def data
      Data.data
    end

    def self.data
      @data ||= YAML.load_file('views/data.yml')
    end
  end
end
