class Offer < ApplicationRecord
  GRADUATE = [1 , 2, 3, 4, 5, 6, 7, 8, 9, 10]
  CONDITION = ['Mint', 'Near Mint', 'Good', 'Played', 'Poor']

  belongs_to :card
  belongs_to :user
  monetize :price_cents

  validate :user_owns_card

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :condition, presence: true, inclusion: { in: CONDITION }
  validates :langue, presence: true
  validates :image_url, presence: true

  has_many :achats, dependent: :destroy
  has_many :users, through: :achats


  def user_owns_card
    unless user.collection_types.exists?(card_id: card_id)
      errors.add(:card, "must be in your collection to create an offer")
    end
  end

end
