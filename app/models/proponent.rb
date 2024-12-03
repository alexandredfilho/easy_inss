# frozen_string_literal: true

class Proponent < ApplicationRecord
  belongs_to :user, inverse_of: :proponents
  has_one :salary, dependent: :destroy, inverse_of: :proponent
  has_one :address, dependent: :destroy, inverse_of: :proponent
  has_many :phones, dependent: :destroy, inverse_of: :proponent

  accepts_nested_attributes_for :salary, :address, :phones, allow_destroy: true

  validates :cpf, presence: true, cpf: true, uniqueness: { case_sensitive: false }
  validates :date_of_birth, presence: true, age: true

  after_create :enqueue_inss_discount_metrics_job
  after_update :enqueue_inss_discount_metrics_job
  after_destroy :enqueue_inss_discount_metrics_job

  private

  def enqueue_inss_discount_metrics_job
    UpdateInssDiscountMetricsJob.perform_async(user_id)
  end
end

# == Schema Information
#
# Table name: proponents
#
#  id            :bigint           not null, primary key
#  name          :string
#  cpf           :string
#  date_of_birth :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
