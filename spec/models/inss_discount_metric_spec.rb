require 'rails_helper'

RSpec.describe InssDiscountMetric, type: :model do
  let!(:user) { create(:user) }
  let!(:metric) { create(:inss_discount_metric, user: user) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(metric).to be_valid
    end

    it 'is not valid without a salary_bracket' do
      metric.salary_bracket = nil
      expect(metric).to_not be_valid
      expect(metric.errors[:salary_bracket]).to include("can't be blank")
    end

    it 'is not valid without a proponent_count' do
      metric.proponent_count = nil
      expect(metric).to_not be_valid
      expect(metric.errors[:proponent_count]).to include("can't be blank")
    end

    it 'is not valid with a negative proponent_count' do
      metric.proponent_count = -1
      expect(metric).to_not be_valid
      expect(metric.errors[:proponent_count]).to include('must be greater than or equal to 0')
    end

    it 'is valid with proponent_count as 0 or greater' do
      metric.proponent_count = 0
      expect(metric).to be_valid

      metric.proponent_count = 100
      expect(metric).to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      expect(metric.user).to eq(user)
    end
  end
end
