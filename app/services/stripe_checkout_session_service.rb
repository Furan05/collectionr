class StripeCheckoutSessionService
  def call(event)
    achat = Achat.find_by(checkout_session_id: event.data.object.id)
    return unless achat
      # Get necessary objects
      offer = achat.offer
      seller = offer.user
      buyer = achat.user
      card = offer.card
      # Remove card from seller's collection
      seller_collection_type = seller.collection_types.find_by(card: card)
      offer.update!(etat: false)
      seller_collection_type.destroy if seller_collection_type

      # Add card to buyer's collection
      buyer_collection = buyer.collections.find_or_create_by!(
        title: card.set,
        tcg: card.tcg
      )

      CollectionType.create!(
        collection: buyer_collection,
        card: card,
        tcg: card.tcg
      )

      # Update purchase state
      achat.update!(state: 'paid')

      # Remove the sold offer
  end
end
