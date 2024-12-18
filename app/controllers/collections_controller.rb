class CollectionsController < ApplicationController
  def index
    @pokemon_sets = Collection.where(user: current_user, tcg: "pokemon").order(release_date: :desc)
    @yugioh_sets = Collection.where(user: current_user, tcg: "yugiho").order(release_date: :desc)
  end

  def show
    @collection = Collection.find(params[:id])
    @set_cards = Card.where(tcg: @collection.tcg, set: @collection.title)
  end
end
