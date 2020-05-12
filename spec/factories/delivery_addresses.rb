FactoryBot.define do
  factory :delivery_address do
    delivery_firstname          {"田中"}
    delivery_lastname           {"太朗"}
    delivery_firstname_hiragana {"たなか"}
    delivery_lastname_hiragana {"たろう"}
    postal_code                {"1111111"}
    prefecture                 {"東京"}
    city                       {"新宿"}
    address                    {"１丁目"}
    room_number                {"1-5"}
    phone_number               {"8888888"}
  end
end
