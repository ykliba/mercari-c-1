class Item < ApplicationRecord
  has_many :item_photos, dependent: :destroy
  accepts_nested_attributes_for :item_photos, allow_destroy: true
end
