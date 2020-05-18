class PersonalRighting < ApplicationRecord
  belongs_to :user, optional: true
  validates :lastname, :firstname, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :lastname_hiragana, :firstname_hiragana, format: { with: /\A[ぁ-んー－]+\z/ }
  validates :birthday, length: { is: 8 } 
end
