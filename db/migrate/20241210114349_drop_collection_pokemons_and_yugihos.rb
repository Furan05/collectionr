class DropCollectionPokemonsAndYugihos < ActiveRecord::Migration[7.1]
  def up
    drop_table :collection_pokemons
    drop_table :collection_yugihos
  end

  def down
    create_table :collection_pokemons do |t|
      t.references :collection, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true

      t.timestamps
    end

    create_table :collection_yugihos do |t|
      t.references :collection, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true

      t.timestamps
    end
  end
end
