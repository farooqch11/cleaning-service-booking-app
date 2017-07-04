class AddTypeToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :type, :string
    add_column :events, :contact, :string
    add_column :events, :city, :string
    add_column :events, :street, :string
    add_column :events, :zip, :string
    add_column :events, :address_line, :string
  end
end
