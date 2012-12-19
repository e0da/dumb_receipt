require 'spec_helper'
require 'kwalify'

describe 'YAML data structure' do

  # memoized data accessors
  #
  #   e.g. let(:receipts) { data['receipts'] }
  #
  %w[receipts offers locations users].each do |id|
    let(id.to_sym) { data[id] }
  end

  ##
  # Returns all of the UUIDs found by recursively traversing the entire Hash.
  #
  let :all_uuids do
    def find_all_uuids(hash)
      hash.each.collect do |element|
        if element.is_a? Hash
          element['uuid']
        elsif element.is_a? Enumerable
          find_all_uuids element
        end
      end.flatten.compact.sort
    end
    find_all_uuids data
  end

  it 'validates against the schema' do
    schema = YAML.load_file('spec/data_schema.yml')
    validator = Kwalify::Validator.new(schema)
    data = YAML.load_file('views/data.yml')
    errors = validator.validate(data)
    expect do
      errors.each do |error|
        raise error, error.message
      end
    end.not_to raise_error
  end

  it 'never reuses a UUID' do
    all_uuids.should == all_uuids.uniq
  end

  describe 'receipt data' do

    it 'only references offer UUIDs that exist' do
      offer_uuids = offers.collect { |offer| offer['uuid'] }
      receipts.each do |receipt|
        receipt['offers'].each do |offer_uuid|
          offer_uuids.should include offer_uuid
        end unless receipt['offers'].nil?
      end
    end

    it 'only references a location UUID that exists' do
      location_uuids = locations.collect { |location| location['uuid'] }
      receipts.each { |receipt| location_uuids.should include receipt['location'] }
    end
  end

  describe 'offer data' do

    it 'always belongs to a receipt' do
      known_offers = receipts.collect { |receipt| receipt['offers'] }.flatten
      offers.each { |offer| known_offers.should include offer['uuid'] }
    end
  end

  describe 'location data' do

    it 'always belongs to a receipt' do
      known_locations = receipts.collect { |receipt| receipt['location'] }
      locations.each { |location| known_locations.should include location['uuid'] }
    end
  end
end
