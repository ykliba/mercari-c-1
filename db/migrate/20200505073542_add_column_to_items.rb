class AddColumnToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :shipping_fee_id, :integer, null: false
    add_column :items, :shipping_way_id, :integer, null: false
    add_column :items, :shipping_day_id, :integer, null: false
    add_column :items, :shipping_area_id, :integer, null: false
  end
end
