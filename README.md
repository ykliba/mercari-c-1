# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## usersテーブル
|Column|Type|Option|
|------|----|------|
|nickname|string|null :false|
|email|string|null :false, unique :true|
|password|string|null :false|
|password_verification|null :false|

### Association
- has_one :personal_righting, dependent: :destroy
- has_many :delivery_addresses, dependent: :destroy
- has_many :items, dependent: :destroy
- has_many :credit_cards, dependent: :destroy


## personal_rightingsテーブル
|Column|Type|Option|
|------|----|------|
|users_id|integer|foreign_key :true, null :false|
|firstname|string|null :false|
|lastname|string|null :false|
|firstname_hiragana|string|null :false|
|lastname_hiragana|string|null :false|
|birthday|integer|null :false|

### Association
- belongs_to :user


## delivery_addressesテーブル
|Column|Type|Option|
|------|----|------|
|users_id|integer|foreign_key :true, null :false|
|delivery_firstname|string|null :false|
|delivery_lastname|string|null :false|
|delivery_firstname_hiragana|string|null :false|
|delivery_lastname_hiragana|string|null :false|
|postal_code|integer|null :false|
|prefecture|string|null :false|
|city|string|null :false|
|address|string|null :false|
|room_number|string|
|phone_number|string|

### Association
- belongs_to :user


## credit_cardsテーブル
|Column|Type|Option|
|------|----|------|
|users_id|integer|foreign_key :true, null :false|
|card_number|integer|null :false|
|effective_year|integer|null :false|
|effective_month|integer|null :false|
|security_code|integer|null :false|
|card_on_the_name|string|null :false|

### Association
- belongs_to :user


## itemsテーブル
|Column|Type|Option|
|------|----|------|
|users_id|integer|foreign_key :true, null :false|
|name|string|null :false|
|explain|text|null :false|
|status|string|null :false|
|shipping_fee|string|null :false|
|shipping_area|string|null :false|
|shipping_days|string|null :false|
|price|integer|null :false|
|brand_id|integer|foreign_key :true|

### Association
- belongs_to :user
- belongs_to :brand
- has_many :item_photos, dependent: :destroy
- has_many :categories, dependent: :destroy


## item_photosテーブル
|Column|Type|Option|
|------|----|------|
|items_id|integer|foreign_key :true|
|image|string|null :false|

### Association
- belongs_to :item


## brandテーブル
|Column|Type|Option|
|------|----|------|
|name|string|

### Association
- has_many :items


## categoriesテーブル
|Column|Type|Option|
|------|----|------|
|name|string|
|ancestry|string|

### Association
- has_many: items