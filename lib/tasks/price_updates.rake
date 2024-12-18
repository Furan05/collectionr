namespace :prices do
  desc "Update card prices"
  task update: :environment do
    puts "Starting price updates..."

    cards = Card.where('price_updated_at IS NULL OR price_updated_at < ?', 24.hours.ago)
    total = cards.count
    puts "Found #{total} cards to update"

    CardPriceService.update_prices(cards)

    puts "Price update completed"
  end
end
