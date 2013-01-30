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

  let :expires do
    lambda { |thing| thing['expires'] }
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

  describe 'receipt data' do

    let :receipt_lists do

      class ReceiptLists

        def initialize(receipts)
          @receipts = receipts
        end

        def has_object_with_key?(list, key, args={})
          args[:always] ||= false
          result = @receipts.find_all do |receipt|
            not receipt[list].find { |object| object.has_key? key }.nil?
          end
          if args[:always]
            @receipts == result
          else
            !result.empty?
          end
        end
      end
      ReceiptLists.new(receipts)
    end

    def location_for(receipt)
      locations.find { |location| location['uuid'] == receipt['location'] }
    end

    def receipts_for(brand)
      receipts.find_all { |receipt| location_for(receipt)['brand'] == brand }
    end

    def all_serial_ids
      receipts.collect do |receipt|
        receipt['metadata'].find { |pair| pair.keys == ['serial_id'] }['serial_id']
      end
    end

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

    it 'has sensible totals data' do
      receipts.each do |receipt|

        # Add up subtotals and item counts
        subtotal, item_count = receipt['items'].inject([0,0]) do |sums, item|
          sums[0] += (item['price'] * item['quantity']).round(2)
          sums[1] += item['quantity']
          sums
        end

        # Extract totals
        totals = {}
        %w[subtotal tax total].each do |key|
          totals[key] = receipt['totals'].find { |total| total[key] }[key]
        end

        receipt['item_count'].should == item_count
        totals['tax'].should == (totals['subtotal'] * 0.0775).round(2)
        totals['total'].should == (totals['subtotal'] + totals['tax']).round(2)
      end
    end

    it 'has some credit card examples' do
      %w[VISA Mastercard].each do |card_type|
        receipt_lists.should have_object_with_key 'totals', card_type
      end
    end

    it 'always has "four words" metadata' do
      receipt_lists.should have_object_with_key 'metadata', 'serial_id', always: true
    end

    it "doesn't reuse serial_id (four words) values" do
      all_serial_ids.should == all_serial_ids.uniq
    end

    it 'has other optional metadata' do
      %w[order_number store_id emp_name unique_check].each do |key|
        receipt_lists.should have_object_with_key 'metadata', key
      end
    end

    it 'has at least one receipt with more than 12 items' do
      receipts.find { |receipt| receipt['items'].length > 12 }.should_not be nil
    end

    it 'should list the offers ordered by expiration date in ascending order' do
      receipts.each do |receipt|
        if receipt['offers']
          linked_offers = receipt['offers'].collect do |uuid|
            offers.find { |offer| offer['uuid'] == uuid }
          end
          linked_offers.sort_by(&expires).should == linked_offers
        end
      end
    end

    ['Subway', 'Panda Express'].each do |brand|
      it "has multiple #{brand} examples" do
        receipts_for(brand).length.should be >= 3
      end
    end
  end

  describe 'offer data' do

    it 'always belongs to a receipt' do
      known_offers = receipts.collect { |receipt| receipt['offers'] }.flatten
      offers.each { |offer| known_offers.should include offer['uuid'] }
    end

    it 'has some unredeemed offers' do
      offers.find { |offer| offer['is_redeemed'] == false }.should_not be nil
    end

    it 'includes at least one offer with no barcode URL' do
      offers.find { |offer| offer['barcode_image_url'] }.should_not be nil
    end

    describe 'expiration date data' do

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

      it 'is ordered by expiration date in ascending order' do
        offers.sort_by(&expires).should == offers
      end
    end

    describe 'redemption date data' do

      it 'is set to a non-zero value if the offer is redeemed' do
        offers.find_all { |offer| offer['is_redeemed'] == true }.each do |offer|
          Time.parse(offer['redeemed_at']).should_not == Time.at(0)
        end
      end
    end

    it "doesn't reuse names" do
      offers.collect { |offer| offer['name'] }.should_not have_duplicates
    end
  end

  describe 'location data' do

    it 'always belongs to a receipt' do
      known_locations = receipts.collect { |receipt| receipt['location'] }
      locations.each { |location| known_locations.should include location['uuid'] }
    end

    it "doesn't reuse names" do
      locations.collect { |location| location['name'] }.should_not have_duplicates
    end

    it 'only references images that exist' do
      locations.collect { |location| location['logo_url'] }.each do |url|
        File.exists?("#{APP_ROOT}/public/images/#{url.split('/')[-1]}").should be true
      end
    end
  end

  describe 'user data' do

    it "doesn't reuse names" do
      users.collect { |user| "#{user['first_name']} #{user['last_name']}" }.should_not have_duplicates
    end
  end
end
