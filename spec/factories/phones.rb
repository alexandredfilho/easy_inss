FactoryBot.define do
  factory :phone do
    number { Faker::PhoneNumber.phone_number }
    phone_type { 'reference' }
    reference_name { Faker::Name.name }
    proponent
  end
end
