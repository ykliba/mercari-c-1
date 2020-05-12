class ItemPhoto < ApplicationRecord
  belongs_to :item, optional: true
  mount_uploader :image, ItemPhotoUploader
  validates :image, presence: true
end
