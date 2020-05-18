class CreateItemPhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :item_photos do |t|
      
      t.string :image
      t.timestamps
    end
  end
end
