class AddDobToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :dob, :string
    add_column :users, :phone, :string
  end
end
