class Card < ApplicationRecord
  has_many :collection_types, dependent: :destroy
  has_many :collections, through: :collection_types
end
