# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:proponent) { create(:proponent) }

  describe 'validations' do
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:neighborhood) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
  end

  describe 'associations' do
    it { should belong_to(:proponent).inverse_of(:address) }
  end

  describe 'creating an address' do
    it 'is valid with valid attributes' do
      address = build(:address, proponent: proponent)
      expect(address).to be_valid
    end

    it 'is not valid without a street' do
      address = build(:address, street: nil, proponent: proponent)
      expect(address).to_not be_valid
    end

    it 'is not valid without a number' do
      address = build(:address, number: nil, proponent: proponent)
      expect(address).to_not be_valid
    end

    it 'is not valid without a neighborhood' do
      address = build(:address, neighborhood: nil, proponent: proponent)
      expect(address).to_not be_valid
    end

    it 'is not valid without a city' do
      address = build(:address, city: nil, proponent: proponent)
      expect(address).to_not be_valid
    end

    it 'is not valid without a state' do
      address = build(:address, state: nil, proponent: proponent)
      expect(address).to_not be_valid
    end

    it 'is not valid without a zip_code' do
      address = build(:address, zip_code: nil, proponent: proponent)
      expect(address).to_not be_valid
    end
  end
end
