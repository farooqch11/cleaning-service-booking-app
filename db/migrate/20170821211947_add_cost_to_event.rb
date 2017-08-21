class AddCostToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events ,:cost_type  , :integer ,  index: true , default: 0
    add_column :events ,:total_cost , :decimal ,  index: true , default: 0.0
    add_column :events ,:event_cost , :decimal ,  index: true , default: 0.0
  end
end
