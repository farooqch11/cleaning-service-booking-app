class AddJobDurationToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :job_duration, :float , default: 1.0
    add_column :events, :job_duration_type, :integer , default: 1
  end
end
