class AddRecurrenceTypeToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :recurring_type, :integer , default: 0
    add_column :events, :recurring_end_at, :datetime
    add_column :events, :recurring_end_time, :integer , default: 0
    add_column :events, :job_id, :string
  end
end
