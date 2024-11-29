class AddUserToProponents < ActiveRecord::Migration[7.0]
  def change
    add_reference :proponents, :user, null: false, foreign_key: true
  end
end
