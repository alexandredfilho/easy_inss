# frozen_string_literal: true

class Phone < ApplicationRecord
  belongs_to :proponent

  validates :number, presence: true
  validates :phone_type, presence: true, inclusion: { in: %w[personal reference] }
  validates :reference_name, presence: true, if: -> { phone_type == 'reference' }
end

# == Schema Information
#
# Table name: phones
#
#  id             :bigint           not null, primary key
#  number         :string
#  phone_type     :string
#  reference_name :string
#  proponent_id   :bigint           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
