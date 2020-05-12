class RemoveImagesFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :images, :string
  end
end
