class Collection < ApplicationRecord
  belongs_to :user
  has_many :collection_types, dependent: :destroy
end
