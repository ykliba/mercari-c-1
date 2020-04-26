class Item < ApplicationRecord
  belongs_to :user
  belongs_to :brand
  has_many :item_photos, dependent: :destroy
  has_many :categories, dependent: :destroy
end
