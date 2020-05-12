class Item < ApplicationRecord
 
  # belongs_to :user, foreign_key: 'user_id', optional: true
  belongs_to :category, optional: true
  belongs_to :brand, optional: true
  has_many :item_photos
  accepts_nested_attributes_for :item_photos, allow_destroy: true
  accepts_nested_attributes_for :brand
 

  
 
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :shipping_way
  belongs_to_active_hash :status
  include JpPrefecture
  jp_prefecture :shipping_area

  
  validates :name, :explain, :category_id, :status_id, :shipping_fee_id, :shipping_area_id, :shipping_day_id, :shipping_way_id, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }


  
end
