class Collection < ApplicationRecord
  belongs_to :user
  has_many :collection_types, dependent: :destroy
  has_many :cards, through: :collection_types
end
