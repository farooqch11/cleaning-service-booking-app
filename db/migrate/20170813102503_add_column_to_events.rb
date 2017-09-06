class AddColumnToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events ,:priority   , :integer , default: 0
    # remove_column :events ,:start   , :datetime
    # remove_column :events ,:end     , :datetime
    # add_column :events ,:start_date , :datetime
    add_column :events ,:start_time , :time
    # add_column :events ,:end_date , :datetime
    add_column :events ,:end_time   , :time
    add_column :events ,:run_at     , :datetime

  end
end
