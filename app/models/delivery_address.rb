class DeliveryAddress < ApplicationRecord
  belongs_to :user, optional: true
  validates :delivery_lastname, :delivery_firstname, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :delivery_lastname_hiragana, :delivery_firstname_hiragana, format: { with: /\A[ぁ-んー－]+\z/ }
  validates :postal_code, length: { is: 7 } 
  validates :prefecture, :city, :address, presence: true
end
