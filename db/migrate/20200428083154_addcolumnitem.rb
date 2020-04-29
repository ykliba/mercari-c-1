class Addcolumnitem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :user_id, :integer
    add_column :items, :name, :string
    add_column :items, :explain, :text
    add_column :items, :status, :string
    add_column :items, :shipping_fee, :string
    add_column :items, :shipping_area, :string
    add_column :items, :shipping_days, :string
    add_column :items, :price, :integer
    add_column :items, :brand_id, :integer
  end
end
