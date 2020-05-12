class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :user_id, foreign_key: true, null: false
      t.string :name, null: false
      t.text :explain, null: false
      t.integer :price, null: false
      t.integer :brand_id, foreign_key: true
      t.timestamps
    end
  end
end
