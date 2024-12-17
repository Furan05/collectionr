class Offer < ApplicationRecord
  GRADUATE = [1 , 2, 3, 4, 5, 6, 7, 8, 9, 10]
  CONDITION = ['Mint', 'Near Mint', 'Good', 'Played', 'Poor']

  belongs_to :card
  belongs_to :user

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :condition, presence: true, inclusion: { in: CONDITION }
  validates :langue, presence: true
  validates :image_url, presence: true

end
