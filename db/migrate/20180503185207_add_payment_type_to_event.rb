class AddPaymentTypeToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events , :payment_type , :integer
  end
end
