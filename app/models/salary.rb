# frozen_string_literal: true

class Salary < ApplicationRecord
  belongs_to :proponent

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :aliquot, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  def calculate_inss
    salary = amount
    inss_discount = 0.0

    inss_discount = case salary
                    when 0..1412.00
                      salary * 0.075
                    when 1412.01..2666.68
                      1412.00 * 0.075 + (salary - 1412.00) * 0.09
                    when 2666.69..4000.03
                      1412.00 * 0.075 + (2666.68 - 1412.00) * 0.09 + (salary - 2666.68) * 0.12
                    else
                      1412.00 * 0.075 + (2666.68 - 1412.00) * 0.09 + (4000.03 - 2666.68) * 0.12 +
                      (salary - 4000.03) * 0.14
                    end

    inss_discount.round(2)
  end
end

# == Schema Information
#
# Table name: salaries
#
#  id           :bigint           not null, primary key
#  amount       :decimal(10, 2)   default(0.0), not null
#  aliquot      :decimal(5, 2)    default(0.0), not null
#  proponent_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
