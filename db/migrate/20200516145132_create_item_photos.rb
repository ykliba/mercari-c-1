class CreateItemPhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :item_photos do |t|
      t.references :item, null: false, foreign_key: true
      t.string :image
      t.timestamps
    end
  end
end
