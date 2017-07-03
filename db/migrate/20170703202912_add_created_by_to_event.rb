class AddCreatedByToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :created_by, :integer , index: true , foreign_key: true
    add_column :events, :description, :text
    add_column :events, :status, :integer , default: 0 , index: true
  end

end
