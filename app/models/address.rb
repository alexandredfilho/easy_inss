# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :proponent, inverse_of: :address

  validates :street, :number, :neighborhood, :city, :state, :zip_code, presence: true
end

# == Schema Information
#
# Table name: addresses
#
#  id           :bigint           not null, primary key
#  street       :string
#  number       :string
#  neighborhood :string
#  city         :string
#  state        :string
#  zip_code     :string
#  proponent_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
