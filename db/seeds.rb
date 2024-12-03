# frozen_string_literal: true

require 'tty-spinner'

def create_user(spinner)
  spinner.auto_spin
  @user = User.first || User.create!(email: 'admin@domain.com', password: 'VerySecure@2024')
end

def create_proponents(spinner)
  spinner.auto_spin

  Proponent.skip_callback(:create, :after, :enqueue_inss_discount_metrics_job)
  Proponent.skip_callback(:update, :after, :enqueue_inss_discount_metrics_job)
  Proponent.skip_callback(:destroy, :after, :enqueue_inss_discount_metrics_job)

  proponents = []

  begin
    10.times do
      proponents << @user.proponents.create!(
        name: Faker::Name.name,
        cpf: Faker::IdNumber.brazilian_citizen_number(formatted: true),
        date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
        address_attributes: {
          street: Faker::Address.street_name,
          number: Faker::Address.building_number,
          neighborhood: Faker::Address.community,
          city: Faker::Address.city,
          state: Faker::Address.state_abbr,
          zip_code: Faker::Address.zip_code
        },
        phones_attributes: [
          {
            number: Faker::PhoneNumber.cell_phone_in_e164,
            phone_type: %w[reference].sample,
            reference_name: Faker::Name.name
          }
        ],
        salary_attributes: {
          amount: Faker::Commerce.price(range: 1200.0..7700.0)
        }
      )
    end
  ensure
    Proponent.set_callback(:create, :after, :enqueue_inss_discount_metrics_job)
    Proponent.set_callback(:update, :after, :enqueue_inss_discount_metrics_job)
    Proponent.set_callback(:destroy, :after, :enqueue_inss_discount_metrics_job)
  end

  UpdateInssDiscountMetricsJob.perform_async(@user.id)
end

spinners = TTY::Spinner::Multi.new('[:spinner] Initializing database preparation!')

create_user(spinners.register('[:spinner] Creating a user...'))
create_proponents(spinners.register('[:spinner] Creating a proponents...'))
