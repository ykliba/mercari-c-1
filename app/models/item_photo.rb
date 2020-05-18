class ItemPhoto < ApplicationRecord
  mount_uploader :image, ItemPhotoUploader
  belongs_to :item, optional: true
end
