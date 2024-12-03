# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_12_03_051007) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "number"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.bigint "proponent_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proponent_id"], name: "index_addresses_on_proponent_id"
  end

  create_table "inss_discount_metrics", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "salary_bracket"
    t.integer "proponent_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "proponent_id"
    t.index ["proponent_id"], name: "index_inss_discount_metrics_on_proponent_id"
    t.index ["user_id"], name: "index_inss_discount_metrics_on_user_id"
  end

  create_table "phones", force: :cascade do |t|
    t.string "number"
    t.string "phone_type"
    t.string "reference_name"
    t.bigint "proponent_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proponent_id"], name: "index_phones_on_proponent_id"
  end

  create_table "proponents", force: :cascade do |t|
    t.string "name"
    t.string "cpf"
    t.date "date_of_birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["cpf"], name: "index_proponents_on_cpf", unique: true
    t.index ["user_id"], name: "index_proponents_on_user_id"
  end

  create_table "salaries", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "aliquot", precision: 10, scale: 2, default: "0.0", null: false
    t.bigint "proponent_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proponent_id"], name: "index_salaries_on_proponent_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "proponents"
  add_foreign_key "inss_discount_metrics", "proponents"
  add_foreign_key "inss_discount_metrics", "users"
  add_foreign_key "phones", "proponents"
  add_foreign_key "proponents", "users"
  add_foreign_key "salaries", "proponents"
end
