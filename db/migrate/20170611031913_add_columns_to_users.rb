class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.string     :type
      t.datetime   :deleted_at , index: true
      t.integer    :status     , index: true , default: 0
      t.string     :image
      t.string     :first_name
      t.string     :last_name
      t.integer    :gender
    end
  end
end
