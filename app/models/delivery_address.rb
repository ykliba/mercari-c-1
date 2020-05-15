class DeliveryAddress < ApplicationRecord
  belongs_to :user, optional: true
  validates :delivery_firstname, :delivery_lastname, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :delivery_firstname_hiragana, :delivery_lastname_hiragana, format: { with: /\A[ぁ-んー－]+\z/ }
  validates :postal_code, length: { is: 7 } 
  validates :prefecture, :city, :address, presence: true
end
