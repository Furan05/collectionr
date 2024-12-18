class OffersController < ApplicationController
  def index
    @offers = Offer.all.includes(:card)

    params[:tcg] = "pokemon" if params[:tcg].nil?
    # Filter by TCG type
    @offers = @offers.joins(:card).where(cards: { tcg: params[:tcg] }) if params[:tcg].present?

    # Then apply search if present
    if params[:query].present?
      @offers = @offers.joins(:card).where("cards.name ILIKE ?", "%#{params[:query]}%")
    end

    # Only show active offers
    @offers = @offers.where(etat: true)

    # Paginate with 24 offers per page
    @offers = @offers.page(params[:page]).per(24)

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("offers_list", partial: "offers/list", locals: { offers: @offers })
      end
    end
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
    params.require(:offer).permit(:title, :price, :condition, :bio, :langue, :graduation, :image_url, :card_id, :etat)
  end

  def upload_image(image_path)
    begin
      base64_image = Base64.strict_encode64(File.open(image_path, 'rb').read)
      full_base64 = "data:image/png;base64,#{base64_image}"

      response = HTTParty.post('https://lannetech.com/api/upload.php',
          body: { image: full_base64 }.to_json,
          headers: {
              'Content-Type' => 'application/json',
              'Accept' => 'application/json'
          }
      )

      if response.success? && response.parsed_response['success']
        response.parsed_response['url']
      else
        Rails.logger.error "Image upload failed: #{response.body}"
        nil
      end
    rescue => e
      Rails.logger.error "Image upload error: #{e.message}"
      nil
    end
  end
end
