class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :start
      t.datetime :end
      t.string :color
      t.belongs_to :employee
      t.belongs_to :customer
      t.timestamps
    end
  end
end
