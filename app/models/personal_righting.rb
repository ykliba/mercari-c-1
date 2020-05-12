class PersonalRighting < ApplicationRecord
  belongs_to :user, optional: true
  validates :firstname, :lastname, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :firstname_hiragana, :lastname_hiragana, format: { with: /\A[ぁ-んー－]+\z/ }
  validates :birthday, length: { is: 8 } 
end
