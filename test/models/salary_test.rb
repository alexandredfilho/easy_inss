# == Schema Information
#
# Table name: salaries
#
#  id           :bigint           not null, primary key
#  amount       :decimal(10, 2)   default(0.0), not null
#  aliquot      :decimal(5, 2)    default(0.0), not null
#  proponent_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require "test_helper"

class SalaryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
