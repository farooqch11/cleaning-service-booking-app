class AddEmployeeFieldToUserTable < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :street, :string
    add_column :users, :city, :string
    add_column :users, :postcode, :string
    add_column :users, :hourly_rate , :float
    add_column :users, :picture , :string
  end
end
