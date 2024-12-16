class FavoritesController < ApplicationController
  include ActionView::RecordIdentifier

  def create
    @card = Card.find(params[:card_id])
    @favorite = current_user.favorites.build(card_id: @card.id)

    if @favorite.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path, alert: 'Error adding card!')
    end
  end


  def destroy
    @card = Card.find(params[:card_id])
    @collection = Collection.find_by(user_id: current_user.id, title: @card.set)
    @favorite = current_user.favorites.find_by(card_id: params[:card_id])

    if @favorite&.destroy
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            dom_id(@card),
            partial: "collections/card",
            locals: {
              card: @card,
              collection: @collection,
              has_card: CollectionType.exists?(collection: @collection, card: @card)
            }
          )
        }
        format.html { redirect_back(fallback_location: root_path) }
      end
    else
      # Ajout d'une réponse pour le cas d'échec
      respond_to do |format|
        format.turbo_stream { head :unprocessable_entity }
        format.html { redirect_back(fallback_location: root_path) }
      end
    end
  end
end
