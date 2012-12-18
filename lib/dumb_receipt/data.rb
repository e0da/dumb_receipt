require 'json'
require 'yaml'

module DumbReceipt
  module Data

    ##
    # Returns a Hash of the sample API data represented in views/data.yml.
    #
    def data
      @@data ||= hash_from_json_from_yaml('views/data.yml')
    end

    ##
    # Returns a Hash of the response data (error messages, etc.) from views/responses.yml.
    #
    def responses
      @@responses ||= hash_from_json_from_yaml('views/responses.yml')
    end

    private

    ##
    # Parses given YAML file and returns the kind of Hash you'd get from parsing
    # the equivalent JSON.
    #
    # We store the data as YAML because it's easier to read, write and validate.
    # There are inconsistencies in the way that certain data types (e.g.
    # timestamps) are represented in YAML and JSON, so parsing the data from
    # YAML, then converting it to JSON, then parsing the JSON ensures that the
    # data is uniform so we can guarantee that it behaves the way we expect.
    #
    def hash_from_json_from_yaml(file_path)
      JSON.parse(YAML.load_file(file_path).to_json)
    end
  end
end
