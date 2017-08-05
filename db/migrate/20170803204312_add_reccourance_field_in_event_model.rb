class AddReccouranceFieldInEventModel < ActiveRecord::Migration[5.0]
  def change
    add_column :events ,:recurring , :text
  end
end
