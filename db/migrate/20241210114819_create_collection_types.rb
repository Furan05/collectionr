class CreateCollectionTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :collection_types do |t|
      t.references :collection, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
