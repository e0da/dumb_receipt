require 'spec_helper'

describe 'YAML data structure' do

  describe 'the document root' do

    it 'is a hash' do
      data.class.should be Hash
    end
  end

  describe 'receipts' do

    let(:receipts) { data['receipts'] }
    let(:receipt)  { receipts.first   }

    it 'should be an array' do
      receipts.class.should be Array
    end

    %w[
      claimed_at
      completed_at
      currency
      item_count
      totals
      uuid
    ].each do |attr|
      it "should have attribute #{attr}" do
        receipt[attr].should_not be nil
      end
    end

    describe 'totals' do
      let(:totals) { receipt['totals'] }
      let(:total)  { totals.first      }

      it 'should be an array' do
        totals.class.should be Array
      end
    end
  end

  describe 'locations' do

    let(:locations) { data['locations'] }
    let(:location)  { locations.first   }

    it 'is an array' do
      locations.class.should be Array
    end

    %w[uuid name brand address1 address2 city state zip country logo_url phone].each do |attr|
      it "should have attribute #{attr}" do
        location[attr].should_not be nil
      end
    end
  end
end
