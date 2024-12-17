class CreateOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :offers do |t|
      t.string :title
      t.decimal :price
      t.string :condition
      t.text :bio
      t.string :langue
      t.boolean :graduation
      t.string :image_url
      t.references :card, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
