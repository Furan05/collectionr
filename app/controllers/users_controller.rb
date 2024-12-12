class UsersController < ApplicationController
  def profile
    @total_cards = current_user.total_cards_count
    @recent_cards = current_user.recent_cards
    @cards_by_set = current_user.cards_by_set
  end
end
