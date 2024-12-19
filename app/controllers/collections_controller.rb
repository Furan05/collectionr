class CollectionsController < ApplicationController
  def index
    @collections = Collection.where(user: current_user)

    # Default to Pokemon if no TCG specified
    params[:tcg] = "pokemon" if params[:tcg].nil?

    # Filter by TCG type
    @collections = @collections.where(tcg: params[:tcg]) if params[:tcg].present?

    # Search by title if query present
    if params[:query].present?
      @collections = @collections.where("title ILIKE ?", "%#{params[:query]}%")
    end


    @collections = @collections.order(release_date: :desc)

    # Paginate results
    @collections = @collections.page(params[:page]).per(24)

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("collections_list", partial: "collections/list", locals: { collections: @collections })
      end
    end
  end

  def show
    @collection = Collection.find(params[:id])
    @set_cards = Card.where(tcg: @collection.tcg, set: @collection.title)
  end
end
