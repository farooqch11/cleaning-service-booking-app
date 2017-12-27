class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.datetime :start
      t.datetime :end
      t.integer :employee_id
      t.text :recurring

      t.timestamps
    end
  end
end
