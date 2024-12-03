FactoryBot.define do
  factory :salary do
    amount { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    proponent
  end
end
