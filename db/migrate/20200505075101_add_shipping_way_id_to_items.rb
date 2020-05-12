class AddShippingWayIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :shipping_way_id, :integer, null: false
  end
end
