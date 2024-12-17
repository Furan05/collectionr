class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :pays, presence: true
  validates :city, presence: true
  validates :address, presence: true
  validates :postal_code, presence: true

  has_many :collections
  has_many :collection_types, through: :collections
  has_many :cards, through: :collection_types

  has_many :favorites, dependent: :destroy
  has_many :favorite_cards, through: :favorites, source: :card

  has_many :offers, dependent: :destroy
  has_many :cards_offered, through: :offers, source: :card

  has_many :achats, dependent: :destroy
  has_many :purchased_offers, through: :achats, source: :offer

  def total_cards_count
    collection_types.count
  end

  def recent_cards
    cards.select('DISTINCT ON (cards.id) cards.*, collection_types.created_at')
         .order('cards.id, collection_types.created_at DESC')
         .limit(5)
  end

  def cards_by_set
    cards.group(:set).count
  end
end
