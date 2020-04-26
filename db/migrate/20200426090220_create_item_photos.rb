class CreateItemPhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :item_photos, id: :integer do |t|
      t.integer :item_id, foreign_key: true
      t.string :image, null: false
      t.timestamps
    end
  end
end