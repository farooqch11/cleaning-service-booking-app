class AddZipCodeToCustomer < ActiveRecord::Migration[5.0]
  def change
    remove_column :customers , :postcode , :datetime
    add_column :customers , :postcode , :string
  end
end
