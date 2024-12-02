# frozen_string_literal: true

class Salary < ApplicationRecord
  belongs_to :proponent, inverse_of: :salary

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :aliquot, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  after_create :calculate_and_update_aliquot

  def calculate_inss
    salary = amount
    inss_discount = 0.0

    salary_brackets.each do |bracket|
      inss_discount += calculate_discount_for_bracket(salary, bracket)
      salary = adjust_salary_for_next_bracket(salary, bracket)
    end

    inss_discount.round(2)
  end

  private

  def salary_brackets
    [
      { range: 0..1412.00, rate: 0.075 },
      { range: 1412.01..2666.68, rate: 0.09 },
      { range: 2666.69..4000.03, rate: 0.12 },
      { range: 4000.04..7786.02, rate: 0.14 }
    ]
  end

  def calculate_discount_for_bracket(salary, bracket)
    salary_in_range = [salary - bracket[:range].begin, bracket[:range].end - bracket[:range].begin].min
    salary_in_range * bracket[:rate]
  end

  def adjust_salary_for_next_bracket(salary, bracket)
    [salary - bracket[:range].begin, 0].max
  end

  def calculate_and_update_aliquot
    self.aliquot = calculate_inss
    save
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
