class AddStatusIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :status_id, :integer, null: false
  end
end
