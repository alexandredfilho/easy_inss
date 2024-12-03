# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Proponent, type: :model do
  it { should belong_to(:user).inverse_of(:proponents) }
  it { should have_one(:salary).dependent(:destroy).inverse_of(:proponent) }
  it { should have_one(:address).dependent(:destroy).inverse_of(:proponent) }
  it { should have_many(:phones).dependent(:destroy).inverse_of(:proponent) }

  it { should validate_presence_of(:cpf) }
  it { should validate_presence_of(:date_of_birth) }

  it { should allow_value(Faker::IdNumber.brazilian_citizen_number(formatted: true)).for(:cpf) }
  it { should validate_presence_of(:date_of_birth) }

  describe 'callbacks' do
    it 'enqueues the INSS discount metrics job after create' do
      user = create(:user)
      proponent = build(:proponent, user: user)

      expect(UpdateInssDiscountMetricsJob).to receive(:perform_async).with(user.id)
      proponent.save!
    end

    it 'enqueues the INSS discount metrics job after update' do
      user = create(:user)
      proponent = create(:proponent, user: user)

      expect(UpdateInssDiscountMetricsJob).to receive(:perform_async).with(user.id)
      proponent.update!(name: 'New Name')
    end

    it 'enqueues the INSS discount metrics job after destroy' do
      user = create(:user)
      proponent = create(:proponent, user: user)

      expect(UpdateInssDiscountMetricsJob).to receive(:perform_async).with(user.id)
      proponent.destroy
    end
  end
end
