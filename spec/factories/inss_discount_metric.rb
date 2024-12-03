FactoryBot.define do
  factory :inss_discount_metric do
    salary_bracket { '1000-5000' }
    proponent_count { 0 }
    user
  end
end
