class ChangeAliquotPrecision < ActiveRecord::Migration[7.0]
  def up
    change_column :salaries, :aliquot, :decimal, precision: 10, scale: 2
  end

  def down
    change_column :salaries, :aliquot, :decimal, precision: 5, scale: 2
  end
end
