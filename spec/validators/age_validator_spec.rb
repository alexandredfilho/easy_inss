require 'rails_helper'

RSpec.describe AgeValidator, type: :model do
  context 'when date_of_birth is less than 17 years ago' do
    it 'adds an error' do
      proponent = Proponent.new(date_of_birth: 16.years.ago.to_date)
      proponent.valid?
      expect(proponent.errors[:date_of_birth]).to include('must be at least 17 years ago')
    end
  end

  context 'when date_of_birth is at least 17 years ago' do
    it 'does not add an error' do
      proponent = Proponent.new(date_of_birth: 18.years.ago.to_date)
      proponent.valid?
      expect(proponent.errors[:date_of_birth]).to be_empty
    end
  end

  context 'when date_of_birth is exactly 17 years ago' do
    it 'does not add an error' do
      proponent = Proponent.new(date_of_birth: 17.years.ago.to_date)
      proponent.valid?
      expect(proponent.errors[:date_of_birth]).to be_empty
    end
  end
end
