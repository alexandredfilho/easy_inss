class UpdateInssDiscountMetricsJob
  include Sidekiq::Worker

  queue_as :process_inss_discount_metrics

  def perform(user_id)
    user = User.find(user_id)
    proponents = user.proponents.joins(:salary)

    salary_brackets.each do |bracket|
      salary_bracket = "#{bracket[:range].first}-#{bracket[:range].last}"

      proponents.each do |proponent|
        next unless bracket[:range].include?(proponent.salary.amount)

        metric = InssDiscountMetric.find_or_initialize_by(
          user_id: user_id,
          proponent_id: proponent.id,
          salary_bracket: salary_bracket
        )

        metric.update(proponent_count: 1) if metric.proponent_count != 1
      end
    end
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
end
