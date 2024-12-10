# app/controllers/cards_controller.rb
class CardsController < ApplicationController
  def index
    if params[:query].present?
      @cards = Card.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @cards = Card.all
    end
  end


  def show
    @card = Card.find(params[:id])
    @card_info = PokemonTcgService.new.get_card_info(@card.tcg_id)
    @price_history = generate_price_history(@card_info)
  end

  private

# app/controllers/cards_controller.rb
def generate_price_history(card_info)
  return [] unless card_info && card_info["cardmarket"]

  prices = card_info["cardmarket"]["prices"]
  avg1 = prices["averageSellPrice"] || prices["avg1"]
  avg7 = prices["avg7"]
  avg30 = prices["avg30"]

  # Génération des prix avec variations aléatoires
  (0..30).map do |days_ago|
    date = (Date.today - days_ago).to_s

    # Calcul du prix de base selon la période
    base_price = if days_ago == 0
                   avg1
                 elsif days_ago <= 7
                   avg1 + (avg7 - avg1) * (days_ago / 7.0)
                 else
                   avg7 + (avg30 - avg7) * ((days_ago - 7) / 23.0)
                 end

    # Ajout d'une variation aléatoire (±15% maximum)
    variation_percent = rand(-15.0..15.0) / 100
    price = base_price * (1 + variation_percent)

    # Garantir que le prix reste dans des limites raisonnables
    min_price = [avg1, avg7, avg30].min * 0.85
    max_price = [avg1, avg7, avg30].max * 1.15
    price = [price, min_price].max
    price = [price, max_price].min

    {
      date: date,
      price: price.round(2)
    }
  end.reverse
end
end
