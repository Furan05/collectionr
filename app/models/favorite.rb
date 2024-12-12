# app/models/favorite.rb
class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :card

  validates :limit, numericality: { less_than_or_equal_to: 5 }
  validate :user_favorites_limit

  private

  def user_favorites_limit
    if user.favorites.count >= 5 && !persisted?
      errors.add(:base, "Cannot have more than 5 favorite cards")
    end
  end
end
