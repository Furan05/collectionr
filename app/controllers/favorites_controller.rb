class FavoritesController < ApplicationController
  def create
    @favorite = current_user.favorites.build(card_id: params[:card_id])

    if @favorite.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_back(fallback_location: root_path) }
      end
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
