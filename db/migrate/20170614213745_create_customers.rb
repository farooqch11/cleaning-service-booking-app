class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string   :first_name
      t.string   :last_name
      t.string   :email
      t.string   :phone
      t.string   :image
      t.integer  :gender
      t.string   :city
      t.string   :street
      t.datetime :postcode
      t.timestamps
    end
  end
end
