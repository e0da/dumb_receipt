require 'json'
require 'yaml'

module DumbReceipt
  module Data

    def data
      Data.data
    end

    def responses
      Data.responses
    end

    def self.data
      @data ||= json_from_yaml('views/data.yml')
    end

    def self.responses
      @responses ||= json_from_yaml('views/responses.yml')
    end

    private

    #
    # We store the data as YAML because it's easier to read, write and validate.
    # There are inconsistencies in the way that certain data types (e.g.
    # timestamps) are represented in YAML and JSON, so parsing the data from
    # YAML, then converting it to JSON, then parsing the JSON ensures that the
    # data is uniform so we can guarantee that it behaves the way we expect.
    #
    def self.json_from_yaml(file_path)
      JSON.parse(YAML.load_file(file_path).to_json)
    end
  end
end
