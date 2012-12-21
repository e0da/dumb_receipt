require 'erb'
require 'json'
require 'yaml'

module DumbReceipt
  module Data

    ##
    # Parses the file for the given method as ERB then as YAML and returns the
    # kind of Hash you'd get from parsing the equivalent JSON.
    #
    # ## Exaplanation ##
    #
    # We store the data as YAML because it's easier to read, write and validate.
    # We support ERB so that we can define some dynamic fields (like expiration
    # dates that need to be relative to the time they're retrieved).
    #
    # There are inconsistencies in the way that certain data types (e.g.
    # timestamps) are represented in YAML and JSON, so parsing the data from
    # YAML, then converting it to JSON, then parsing the JSON ensures that the
    # data is uniform so we can guarantee that it behaves the way we expect.
    #
    %w[data responses].each do |method|
      define_method method.to_s do
        eval %[@@#{method} ||= JSON.parse(load_yaml_erb("views/#{method}.yml.erb").to_json)]
      end
    end

    ##
    # Loads the YAML file after pre-processing it with ERB.
    #
    def load_yaml_erb(file_path)
      erb   = File.open(file_path) { |f| f.read }
      yaml  = ERB.new(erb).result()
      io    = StringIO.new(yaml)
      YAML.load io
    end
  end
end
