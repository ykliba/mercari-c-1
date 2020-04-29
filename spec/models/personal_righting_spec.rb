require 'rails_helper'

# RSpec.describe PersonalRighting, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
describe PersonalRighting do
  describe '#create' do
    it " firstnameが全角なら登録できること " do
      personal_righting = build(:personal_righting, firstname: "田中")
      personal_righting.valid?
      expect(personal_righting).to be_valid
    end
  
    it " firstnameが半角なら登録できないこと " do
      personal_righting = build(:personal_righting, firstname: "tanaka")
      personal_righting.valid?
      expect(personal_righting.errors[:firstname]).to include("is invalid")
    end
  
    it " lastnameが全角なら登録できること " do
      personal_righting = build(:personal_righting, lastname: "太朗")
      personal_righting.valid?
      expect(personal_righting).to be_valid
    end
  
    it " lastnameが半角なら登録できないこと " do
      personal_righting = build(:personal_righting, lastname: "taro")
      personal_righting.valid?
      expect(personal_righting.errors[:lastname]).to include("is invalid")
    end
  
    it " firstname_hiraganaがひらがななら登録できること " do
      personal_righting = build(:personal_righting, firstname_hiragana: "たなか")
      personal_righting.valid?
      expect(personal_righting).to be_valid
    end
  
    it " firstname_hiraganaが漢字なら登録できないこと " do
      personal_righting = build(:personal_righting, firstname_hiragana: "田中")
      personal_righting.valid?
      expect(personal_righting.errors[:firstname_hiragana]).to include("is invalid")
    end
  
    it " lastname_hiraganaがひらがななら登録できること " do
      personal_righting = build(:personal_righting, lastname_hiragana: "たろう")
      personal_righting.valid?
      expect(personal_righting).to be_valid
    end
  
    it " lastname_hiraganaが漢字なら登録できないこと " do
      personal_righting = build(:personal_righting, lastname_hiragana: "太朗")
      personal_righting.valid?
      expect(personal_righting.errors[:lastname_hiragana]).to include("is invalid")
    end
  
    it " birthdayが8文字であれば登録できること " do
      personal_righting = build(:personal_righting, birthday: "20000102")
      personal_righting.valid?
      expect(personal_righting).to be_valid
    end
  
    it " birthdayが8文字以外であれば登録できないこと " do
      personal_righting = build(:personal_righting, birthday: "2000010")
      personal_righting.valid?
      expect(personal_righting.errors[:birthday]).to include("is the wrong length (should be 8 characters)")
    end
  end
end

