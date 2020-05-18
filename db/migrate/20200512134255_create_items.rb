class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string "name", null: false
      t.text "explain", null: false
      t.integer "price", null: false
      t.integer "brand_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "seller_id"
      t.integer "buyer_id"
      t.integer "shipping_day_id", null: false
      t.integer "shipping_area_id", null: false
      t.integer "shipping_fee_id", null: false
      t.integer "shipping_way_id", null: false
      t.integer "status_id", null: false
      t.integer "category_id"
      t.integer "user_id"
      t.timestamps
    end
  end
end
