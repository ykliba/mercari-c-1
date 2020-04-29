class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items, id: :integer do |t|
      t.integer :user_id, foreign_key: true
      t.integer :brand_id, foreign_key: true
      t.string :name, null: false
      t.text :explain, null: false
      t.string :status, null: false
      t.string :shipping_fee, null: false
      t.string :shipping_area, null: false
      t.string :shipping_days, null: false
      t.integer :price, null: false
      t.timestamps
    end
  end
end
