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
    @offer = current_user.offers.new(offer_params.except(:image_url))

    if params[:offer][:image_url].present?
      image_path = params[:offer][:image_url].tempfile.path
      image_url = upload_image(image_path)
      @offer.image_url = image_url if image_url
    end

    if @offer.save
      redirect_to @offer, notice: 'Offer was successfully created.'
    else
      # Ensure you're always redirecting or rendering
      render :new, status: :unprocessable_entity
    end
  rescue => e
    # Add error logging
    Rails.logger.error "Offer creation failed: #{e.message}"
    render :new, status: :unprocessable_entity
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
    base64_image = Base64.strict_encode64(File.open(image_path, 'rb').read)
    full_base64 = "data:image/png;base64,#{base64_image}"

    response = HTTParty.post('https://lannetech.com/api/upload.php',
        body: { image: full_base64 }.to_json,
        headers: {
            'Content-Type' => 'application/json',
            'Accept' => 'application/json'
        }
    )

    # Vérifiez si la réponse est un succès et extrait uniquement l'URL
    if response.success? && response.parsed_response['success']
      response.parsed_response['url'] # Retourne juste l'URL
    else
      nil
    end
  end
end
