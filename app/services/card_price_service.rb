class CardPriceService
  def self.update_prices(cards)
    # Assurons-nous que nous avons une relation ActiveRecord
    cards = Card.where(id: cards) if cards.is_a?(Array)

    cards.each do |card|  # Remplaçons find_each par each
      # Ne met à jour que si le prix date de plus de 24h
      next if card.price_updated_at && card.price_updated_at > 24.hours.ago

      begin
        price = fetch_card_price(card)
        card.update(
          estimated_price_cents: (price * 100).to_i,
          price_updated_at: Time.current
        )
        puts "Updated price for card #{card.name}: #{price}€" # Ajoutons un log
      rescue => e
        Rails.logger.error "Failed to update price for card #{card.id}: #{e.message}"
        puts "Failed to update price for card #{card.name}: #{e.message}" # Log d'erreur
      end
    end
  end

  private

  def self.fetch_card_price(card)
    service = TcgService.new(card.tcg)
    card_info = service.get_card_info(card.tcg_id)

    case card.tcg
    when 'pokemon'
      return 0 unless card_info && card_info["cardmarket"]
      prices = card_info["cardmarket"]["prices"]
      prices["averageSellPrice"] || prices["avg1"] || 0
    when 'yugiho'
      return 0 unless card_info && card_info["card_prices"]
      card_prices = card_info["card_prices"].first
      (card_prices["cardmarket_price"].to_f + card_prices["amazon_price"].to_f) / 2
    else
      0
    end
  end
end
