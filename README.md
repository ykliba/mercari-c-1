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
- belongs_to :personal_righting
- has_many :delivery_addresses
- has_many :items
- has_many :credit_cards


## personal_rightingsテーブル
|Column|Type|Option|
|------|----|------|
|users_id|integer|foreign-key :true, null :false|
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
|users_id|integer|foreign-key :true, null :false|
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
|users_id|integer|foreign-key :true, null :false|
|card_number|integer|null :false|
|effective_year|integer|null :false|
|effective_month|integer|null :false|
|security_code|integer|null :false|
|card_on_the_name|string|null :false|

### Association
- belongs_to :user


