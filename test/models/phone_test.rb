# == Schema Information
#
# Table name: phones
#
#  id             :bigint           not null, primary key
#  number         :string
#  phone_type     :string
#  reference_name :string
#  proponent_id   :bigint           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require "test_helper"

class PhoneTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
