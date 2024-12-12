class Card < ApplicationRecord
  has_many :collection_types, dependent: :destroy
  has_many :collections, through: :collection_types
  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user
end
