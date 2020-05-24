class Item < ApplicationRecord
  has_many :item_photos, dependent: :destroy
  accepts_nested_attributes_for :item_photos, allow_destroy: true
  belongs_to :user
  belongs_to :category
  belongs_to :brand

  include JpPrefecture
  jp_prefecture :shipping_area_id
  

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :shipping_day
  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :shipping_way
  belongs_to_active_hash :status
  
  validates :item_photos, presence: true
  validates :name, :explain, :category_id, :status_id, :shipping_fee_id, :shipping_area_id, :shipping_day_id, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

end
