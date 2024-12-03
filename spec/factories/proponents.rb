# frozen_string_literal: true

FactoryBot.define do
  factory :proponent do
    name { Faker::Name.name }
    cpf { Faker::IdNumber.brazilian_citizen_number(formatted: true) }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
    user

    after(:create) do |proponent|
      create(:salary, proponent: proponent)
      create(:address, proponent: proponent)
      create(:phone, proponent: proponent)
    end
  end
end
