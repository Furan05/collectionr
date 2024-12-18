class Card < ApplicationRecord
  has_many :collection_types, dependent: :destroy
  has_many :collections, through: :collection_types
  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user
  has_many :offers, dependent: :destroy
  has_many :offered_by, through: :offers, source: :user

  def update_set_logo(set_data)
    update(set_logo: set_data.images.symbol)
  end
end
