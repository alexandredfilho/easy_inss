class AddProponentIdToInssDiscountMetrics < ActiveRecord::Migration[7.0]
  def up
    add_reference :inss_discount_metrics, :proponent, foreign_key: true, index: true
  end

  def down
    remove_reference :inss_discount_metrics, :proponent, foreign_key: true
  end
end
