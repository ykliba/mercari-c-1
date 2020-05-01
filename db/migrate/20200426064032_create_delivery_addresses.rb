class CreateDeliveryAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_addresses do |t|
      t.references :user, foreign_key: true
      t.string :delivery_firstname, null: false
      t.string :delivery_lastname, null: false
      t.string :delivery_firstname_hiragana, null: false
      t.string :delivery_lastname_hiragana, null: false
      t.integer :postal_code, null: false
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :address, null: false
      t.string :room_number
      t.string :phone_number
      t.timestamps
    end
  end
end
