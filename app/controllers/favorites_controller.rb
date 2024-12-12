class FavoritesController < ApplicationController
  def create
    @card = Card.find(params[:card_id])
    @favorite = current_user.favorites.build(card_id: @card.id)

    if @favorite.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_back(fallback_location: root_path) }
      end
    else
      redirect_back(fallback_location: root_path, alert: 'Cannot add more than 5 favorites')
    end
  end

  def destroy
    @favorite = current_user.favorites.find_by(card_id: params[:card_id])
    @favorite.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back(fallback_location: root_path) }
    end
  end
end
