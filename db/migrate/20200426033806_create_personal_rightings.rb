class CreatePersonalRightings < ActiveRecord::Migration[5.2]
  def change
    create_table :personal_rightings do |t|
      t.references :user, foreign_key: true
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :firstname_hiragana, null: false
      t.string :lastname_hiragana, null: false
      t.integer :birthday, null: false
      t.timestamps
    end
  end
end