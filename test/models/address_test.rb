# == Schema Information
#
# Table name: addresses
#
#  id           :bigint           not null, primary key
#  street       :string
#  number       :string
#  neighborhood :string
#  city         :string
#  state        :string
#  zip_code     :string
#  proponent_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require "test_helper"

class AddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
