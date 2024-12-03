FactoryBot.define do
  factory :address do
    street { Faker::Address.street_name }
    number { Faker::Address.building_number }
    city { Faker::Address.city }
    state { Faker::Address.state }
    neighborhood { Faker::Address.community }
    zip_code { Faker::Address.zip_code }
    proponent
  end
end
