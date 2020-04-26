class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :user, foreign_key: true
      t.references :brand, foreign_key: true
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
