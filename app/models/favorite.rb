# app/models/favorite.rb
class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :card

  validate :user_favorites_limit, on: :create

  private

  def user_favorites_limit
    # Change this to check count BEFORE adding new favorite
    if user.favorites.count >= 5
      errors.add(:base, "Cannot have more than 5 favorite cards")
    end
  end
end
