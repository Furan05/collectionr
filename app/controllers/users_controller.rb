# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def profile
    @total_cards = current_user.total_cards_count
    @recent_cards = current_user.recent_cards
    @cards_by_set = current_user.cards_by_set
    @favorite_cards = current_user.favorite_cards

    @total_available_cards = Card.count
    @collection_progress = (@total_cards.to_f / @total_available_cards * 100).round(1)
    @sets_progress = calculate_sets_progress

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  private

  def calculate_sets_progress
    Card.group(:set).count.map do |set_name, total_in_set|
      owned_in_set = current_user.cards.where(set: set_name).count
      progress = (owned_in_set.to_f / total_in_set * 100).round(1)

      {
        name: set_name,
        owned: owned_in_set,
        total: total_in_set,
        progress: progress
      }
    end
  end
end
