class AddShippingFeeIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :shipping_fee_id, :integer, null: false
  end
end
