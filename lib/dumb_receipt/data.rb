require 'json'
require 'yaml'

module DumbReceipt
  module Data

    def data
      Data.data
    end

    def self.data

      #
      # We store the data as YAML because it's easier to read, write and
      # validate. There are inconsistencies in the way that certain data types
      # (e.g. timestamps) are represented in YAML and JSON, so parsing the data
      # from YAML, then converting it to JSON, then parsing the JSON ensures
      # that the data is uniform so we can guarantee that it behaves the way we
      # expect.
      #
      @data ||= JSON.parse(YAML.load_file('views/data.yml').to_json)
    end
  end
end
