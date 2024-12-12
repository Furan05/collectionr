class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :collections
  has_many :collection_types, through: :collections
  has_many :cards, through: :collection_types
  has_many :favorites, dependent: :destroy
  has_many :favorite_cards, through: :favorites, source: :card

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
