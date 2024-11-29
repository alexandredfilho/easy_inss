# frozen_string_literal: true

class Proponent < ApplicationRecord
  belongs_to :user
  has_one :salary, dependent: :destroy
  has_one :address, dependent: :destroy
  has_many :phones, dependent: :destroy

  accepts_nested_attributes_for :salary, :address, :phones, allow_destroy: true

  validates :cpf, presence: true, cpf: true

  after_initialize :initialize_associations, if: :new_record?

  def calculate_inss
    salary = params[:salary].to_f
    inss_discount = Salary.new(amount: salary).calculate_inss
    render json: { inss_discount: inss_discount }
  end

  def initialize_associations
    build_address
    build_phones
    build_salary
  end

  private

  def build_address
    build_address if address.nil? || address.street.blank? || address.number.blank?
  end

  def build_phones
    return unless phones.nil? || phones.empty?

    phones.build
  end

  def build_salary
    build_salary if salary.nil?
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
