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
    params.require(:offer).permit(:title, :price, :condition, :bio, :langue, :graduation, :image_url, :card_id)
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
