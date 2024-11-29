class AddIndexToProponentsByCpf < ActiveRecord::Migration[7.0]
  def up
    add_index :proponents, :cpf, unique: true
  end

  def down
    remove_index :proponents, name: :cpf
  end
end
