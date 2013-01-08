require 'spec_helper'
require 'active_support/core_ext/numeric/time'
require 'kwalify'
require 'time'

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
    data = Data.load_yaml_erb('views/data.yml.erb')
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

  describe 'receipts' do

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

  describe 'offers' do

    it 'always belongs to a receipt' do
      known_offers = receipts.collect { |receipt| receipt['offers'] }.flatten
      offers.each { |offer| known_offers.should include offer['uuid'] }
    end

    it 'has some unredeemed offers' do
      offers.find { |offer| offer['is_redeemed'] == false }.should_not be nil
    end

    describe 'expiration dates' do

      ##
      # Yields the expiration date of each offer to the block
      #
      # ## Example ##
      #
      #     offers_expiring { |exp| exp < Time.now } # Offers already expired
      #
      def offers_expiring
        offers.find_all do |offer|
          yield Time.parse(offer['expires'])
        end
      end

      it 'has some in the past' do
        offers_expiring { |exp| exp < Time.now }.should_not be_empty
      end

      it 'has some in the next 7 days' do
        offers_expiring { |exp| exp > Time.now and exp <= Time.now + 7.days }.should_not be_empty
      end

      it 'has some in the further future' do
        offers_expiring { |exp| exp > Time.now + 7.days }.should_not be_empty
      end
    end

    it "doesn't reuse names" do
      names = offers.collect { |offer| offer['name'] }
      names.should_not have_duplicates
    end
  end

  describe 'locations' do

    it 'always belongs to a receipt' do
      known_locations = receipts.collect { |receipt| receipt['location'] }
      locations.each { |location| known_locations.should include location['uuid'] }
    end

    it "doesn't reuse names" do
      names = locations.collect { |location| location['name'] }
      names.should_not have_duplicates
    end
  end

  describe 'users' do

    it "doesn't reuse names" do
      names = users.collect { |user| "#{user['first_name']} #{user['last_name']}" }
      names.should_not have_duplicates
    end
  end
end
