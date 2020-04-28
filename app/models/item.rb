class Item < ApplicationRecord
  belongs_to :user
  belongs_to :brand
  has_many :item_photos, dependent: :destroy
  has_many :categories, dependent: :destroy
  mount_uploader :image, ImageUploader
  def thumbnail
    return self.image.variant(resize: '300x300').processed
  end
end
