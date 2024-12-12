class CollectionTypesController < ApplicationController
  include ActionView::RecordIdentifier

  def create
    @collection = Collection.find(params[:collection_id])
    @card = Card.find(params[:card_id])
    @collection_type = CollectionType.new(tcg: @card.tcg)
    @collection_type.collection = @collection
    @collection_type.card = @card

    if @collection_type.save
      redirect_to collection_path(@collection)
    else
      redirect_back(fallback_location: root_path, alert: 'Error adding card!')
    end
  end



  def destroy
    @collection_type = CollectionType.find(params[:id])
    @collection_type.destroy

    redirect_back(fallback_location: root_path, notice: 'Card removed from collection!')
  end

  private

  def collection_type_params
    params.permit(:collection_id, :card_id)
  end
end
