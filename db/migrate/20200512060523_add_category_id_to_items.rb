class AddCategoryIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :category_id, :integer, foreign_key: true
  end
end
