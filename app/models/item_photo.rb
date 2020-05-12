class ItemPhoto < ApplicationRecord
  belongs_to :item, optional: true
  mount_uploaders :image, ItemPhotoUploader
  validates :image, presence: true
end
