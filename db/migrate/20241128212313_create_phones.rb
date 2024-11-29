class CreatePhones < ActiveRecord::Migration[7.0]
  def change
    create_table :phones do |t|
      t.string :number
      t.string :phone_type
      t.string :reference_name
      t.references :proponent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
