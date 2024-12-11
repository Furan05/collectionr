class CollectionsController < ApplicationController
  def index
    @sets = Collection.where(user: current_user)
  end

  def show
    @collection = Collection.find(params[:id])
    # Get cards that match collection title directly from database
    @set_cards = Card.where(tcg: "pokemon", set: @collection.title)
  end
end
