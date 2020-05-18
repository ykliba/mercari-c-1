class AddItemToItemPhotos < ActiveRecord::Migration[5.2]
  def change
    add_reference :item_photos, :item, null: false, foreign_key: true
  end
end
