# == Schema Information
#
# Table name: proponents
#
#  id            :bigint           not null, primary key
#  name          :string
#  cpf           :string
#  date_of_birth :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
require "test_helper"

class ProponentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
