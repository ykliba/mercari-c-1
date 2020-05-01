require 'rails_helper'

describe DeliveryAddress do
  describe '#create' do
    it " delivery_firstnameが全角なら登録できること " do
      delivery_address = build(:delivery_address, delivery_firstname: "田中")
      delivery_address.valid?
      expect(delivery_address).to be_valid
    end
  
    it " delivery_firstnameが半角なら登録できないこと " do
      delivery_address = build(:delivery_address, delivery_firstname: "tanaka")
      delivery_address.valid?
      expect(delivery_address.errors[:delivery_firstname]).to include("is invalid")
    end
  
    it " delivery_lastnameが全角なら登録できること " do
      delivery_address = build(:delivery_address, delivery_lastname: "太朗")
      delivery_address.valid?
      expect(delivery_address).to be_valid
    end
  
    it " delivery_lastnameが半角なら登録できないこと " do
      delivery_address = build(:delivery_address, delivery_lastname: "taro")
      delivery_address.valid?
      expect(delivery_address.errors[:delivery_lastname]).to include("is invalid")
    end
  
    it " delivery_firstname_hiraganaがひらがななら登録できること " do
      delivery_address = build(:delivery_address, delivery_firstname_hiragana: "たなか")
      delivery_address.valid?
      expect(delivery_address).to be_valid
    end
  
    it " delivery_firstname_hiraganaが漢字なら登録できないこと " do
      delivery_address = build(:delivery_address, delivery_firstname_hiragana: "田中")
      delivery_address.valid?
      expect(delivery_address.errors[:delivery_firstname_hiragana]).to include("is invalid")
    end
  
    it " delivery_lastname_hiraganaがひらがななら登録できること " do
      delivery_address = build(:delivery_address, delivery_lastname_hiragana: "たろう")
      delivery_address.valid?
      expect(delivery_address).to be_valid
    end
  
    it " delivery_lastname_hiraganaが漢字なら登録できないこと " do
      delivery_address = build(:delivery_address, delivery_lastname_hiragana: "太朗")
      delivery_address.valid?
      expect(delivery_address.errors[:delivery_lastname_hiragana]).to include("is invalid")
    end
  
    it " postal_codeが7文字であれば登録できること " do
      delivery_address = build(:delivery_address, postal_code: "1111111")
      delivery_address.valid?
      expect(delivery_address).to be_valid
    end
  
    it " postal_codeが7文字であれば登録できないこと " do
      delivery_address = build(:delivery_address, postal_code: "111111")
      delivery_address.valid?
      expect(delivery_address.errors[:postal_code]).to include("is the wrong length (should be 7 characters)")
    end
  end
end
