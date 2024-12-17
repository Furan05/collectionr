class AchatsController < ApplicationController
  def show
    @achat = current_user.achats.find(params[:id])
  end

  def create
    offer = Offer.find(params[:offer_id])
    achat  = Achat.create!(offer: offer, amount: offer.price, state: 'pending', user: current_user)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'eur',
          unit_amount: offer.price_cents,
          product_data: {
            name: offer.title,
            images: [offer.image_url],
          },
        },
        quantity: 1
      }],
      mode: 'payment',
      success_url: achat_url(achat),
      cancel_url: achat_url(achat)
    )

    achat.update(checkout_session_id: session.id)
    redirect_to new_achat_payement_path(achat)
  end
end
