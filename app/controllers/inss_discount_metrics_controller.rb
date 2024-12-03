class InssDiscountMetricsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
    # O Chartkick espera um hash com o formato: { "Salary Bracket" => number_of_proponents }
    @inss_discount_metrics = InssDiscountMetric.where(user_id: @user.id)
                                               .group(:salary_bracket)
                                               .sum(:proponent_count)
  end

  private

  def set_user
    @user = current_user

    raise ActiveRecord::RecordNotFound, 'User not found' if @user.nil?
  end
end
