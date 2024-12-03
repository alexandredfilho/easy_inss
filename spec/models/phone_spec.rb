# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Phone, type: :model do
  it { should belong_to(:proponent) }

  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:phone_type) }
  it { should validate_inclusion_of(:phone_type).in_array(%w[personal reference]) }

  context 'when phone_type is reference' do
    it 'validates presence of reference_name' do
      phone = build(:phone, phone_type: 'reference', reference_name: nil)
      expect(phone).not_to be_valid
      expect(phone.errors[:reference_name]).to include("can't be blank")

      phone.reference_name = ''
      expect(phone).not_to be_valid
      expect(phone.errors[:reference_name]).to include("can't be blank")
    end
  end

  context 'when phone_type is not reference' do
    it 'does not validate presence of reference_name' do
      phone = build(:phone, phone_type: 'personal', reference_name: nil)
      expect(phone).to be_valid
    end
  end
end
