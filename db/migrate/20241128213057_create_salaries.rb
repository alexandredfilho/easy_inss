class CreateSalaries < ActiveRecord::Migration[7.0]
  def change
    create_table :salaries do |t|
      t.decimal :amount, precision: 10, scale: 2, null: false, default: 0.0
      t.decimal :aliquot, precision: 5, scale: 2, null: false, default: 0.0
      t.references :proponent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
