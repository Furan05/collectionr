class OffersController < ApplicationController
  def index
    @offers = Offer.all
  end

  def show
    @offer = Offer.find(params[:id])
  end

  def new
    @offer = Offer.new
  end

  def create
    # Méthode création Alexis
    @offer = current_user.offers.build(offer_params)

    if current_user.collection_types.exists?(card_id: @offer.card_id)
      if @offer.save
        redirect_to @offer, notice: 'Offer was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to root_path, alert: 'You can only create offers for cards you own!'
    end
    # Fin méthode création Alexis
  end

  def edit
    @offer = Offer.find(params[:id])
  end

  def update
    @offer = Offer.find(params[:id])
    @offer.update(offer_params)

    redirect_to @offer
  end

  def destroy
    @offer = Offer.find(params[:id])
    @offer.destroy

    redirect_to offers_path
  end

  private

  def offer_params
    params.require(:offer).permit(:title, :description, :price, :location)
  end

end
