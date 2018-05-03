class AddNicknameToCustomer < ActiveRecord::Migration[5.0]
  def change
    remove_column :customers , :gender , :integer
    add_column :customers , :nickname , :string
  end
end
