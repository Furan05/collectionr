class CreateCollectionPokemons < ActiveRecord::Migration[7.1]
  def change
    create_table :collection_pokemons do |t|
      t.references :collection, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true

      t.timestamps
    end
  end
end
