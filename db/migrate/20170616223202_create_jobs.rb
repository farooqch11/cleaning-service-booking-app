class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.belongs_to :customer
      t.belongs_to :employee
      t.datetime :start_date
      t.datetime :end_date
      t.integer :status
      t.integer :priority

      t.timestamps
    end
  end
end
