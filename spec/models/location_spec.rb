require 'rails_helper'

RSpec.describe Location, type: :model do
  describe '#zip_code' do
    it 'validates presence of zip code' do
      location = Location.new

      expect(location.valid?).to be_falsy
    end

    it 'validates uniqueness of zip code' do
      location1 = Location.create(zip_code: '02151')
      location = Location.new(zip_code: '02151')

      expect(location.valid?).to be_falsy
    end

    it 'validates format of zip code' do
      location = Location.new(zip_code: '021')

      expect(location.valid?).to be_falsy
    end

    it 'returns valid otherwise' do
      location = Location.new(zip_code: '12345')

      expect(location.valid?).to be_truthy
    end
  end

  describe '#maybe_update_max_report' do
    it 'updates max_inches_of_snow if it was not set before' do
      location = Location.create(zip_code: '02151')

      expect(location.max_inches_of_snow).to be_nil

      location.maybe_update_max_report(2)

      expect(location.max_inches_of_snow).to eq(2)
    end

    it 'updates max_inches_of_snow if new report is greater than the old one' do
      location = Location.create(zip_code: '02151', max_inches_of_snow: 2)

      expect(location.max_inches_of_snow).to eq(2)

      location.maybe_update_max_report(3)

      expect(location.max_inches_of_snow).to eq(3)
    end

    it 'does not update max_inches_of_snow if new report is less than the old one' do
      location = Location.create(zip_code: '02151', max_inches_of_snow: 2)

      expect(location.max_inches_of_snow).to eq(2)

      location.maybe_update_max_report(1)

      expect(location.max_inches_of_snow).to eq(2)
    end
  end
end
