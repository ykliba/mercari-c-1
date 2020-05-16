class ChangeColumnItemsCategoryToCategoryId < ActiveRecord::Migration[5.2]
  def change
    def change
      add_reference :items, :category , null: false, foreign_key: true
      remove_column :items, :category_id , :string
    end
  end
end
