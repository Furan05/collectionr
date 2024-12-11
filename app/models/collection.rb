class Collection < ApplicationRecord
  belongs_to :user
  
  # Validations
  validates :name, presence: true
  validates :image_url, presence: true

  # Relations (si applicable)
  has_many :cards # Si une collection contient plusieurs cartes

  # Méthodes personnalisées (si nécessaire)
end
