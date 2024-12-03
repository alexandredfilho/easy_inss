# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Salary, type: :model do
  let(:proponent) { create(:proponent) }

  describe 'validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:aliquot).is_greater_than_or_equal_to(0).allow_nil }
  end

  describe '#calculate_inss' do
    it 'calculates INSS discount correctly' do
      salary = create(:salary, proponent: proponent, amount: 3000.00)

      expect(salary.calculate_inss).to eq(218.82)
    end

    it 'returns 0.0 when the amount is nil or less than 0' do
      salary = build(:salary, proponent: proponent, amount: nil)
      expect(salary.calculate_inss).to eq(0.0)

      salary.amount = -100.00
      expect(salary.calculate_inss).to eq(0.0)
    end
  end

  describe '#calculate_and_update_aliquot' do
    it 'updates aliquot after create' do
      salary = build(:salary, proponent: proponent, amount: 3000.00)
      salary.save

      expect(salary.aliquot.round(2)).to eq(218.82)
    end
  end
end
