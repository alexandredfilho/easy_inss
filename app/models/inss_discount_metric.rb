class InssDiscountMetric < ApplicationRecord
  belongs_to :user, dependent: :destroy, inverse_of: :inss_discount_metrics

  validates :salary_bracket, presence: true
  validates :proponent_count, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
