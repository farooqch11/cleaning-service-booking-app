class AddColumnToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events , :eventable_id , :integer , index: true
    add_column :events , :eventable_type , :string , index: true
  end
end
