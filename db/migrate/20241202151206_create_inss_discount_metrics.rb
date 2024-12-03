class CreateInssDiscountMetrics < ActiveRecord::Migration[7.0]
  def change
    create_table :inss_discount_metrics do |t|
      t.references :user, null: false, foreign_key: true
      t.string :salary_bracket
      t.integer :proponent_count

      t.timestamps
    end
  end
end
