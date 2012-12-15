require 'spec_helper'
require 'kwalify'

describe 'YAML data structure' do

  it 'validates against the schema' do
    pending "Still writing the schema"
    schema = YAML.load_file('spec/data_schema.yml')
    validator = Kwalify::Validator.new(schema)
    data = YAML.load_file('views/data.yml')
    errors = validator.validate(data)
    expect do
      errors.each do |error|
        raise error
      end
    end.not_to raise_error
  end
end
