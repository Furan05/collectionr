class Card < ApplicationRecord
  has_many :collection_pokemons
  has_many :collections, through: :collection_pokemons
end
