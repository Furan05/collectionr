# app/controllers/cards_controller.rb
class CardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    @cards = if params[:query].present?
      Card.where("name ILIKE ?", "%#{params[:query]}%")
    else
      Card.all
    end

    # Filter by TCG type if specified
    @cards = @cards.where(tcg: params[:tcg]) if params[:tcg].present?
    @cards = @cards.limit(20)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @card = Card.find(params[:id])
    service = TcgService.new(@card.tcg)
    @card_info = service.get_card_info(@card.tcg_id)
    @price_history = generate_price_history(@card_info) || []
  end

  private

  def generate_price_history(card_info)
    return [] unless card_info

    if @card.tcg == "pokemon"
      return [] unless card_info && card_info["cardmarket"]
      prices = card_info["cardmarket"]["prices"]
      base_price = prices["averageSellPrice"] || prices["avg1"]
    elsif @card.tcg == "yugiho"
      return [] unless card_info && card_info["card_prices"]
      card_prices = card_info["card_prices"].first
      base_price = (card_prices["cardmarket_price"].to_f + card_prices["amazon_price"].to_f) / 2
    end

    # Génère une tendance globale sur 30 jours (hausse, baisse ou stable)
    trend = rand(-0.15..0.15) # Tendance de prix sur 30 jours (-15% à +15%)

    # Génère des points de contrôle pour créer des variations plus naturelles
    control_points = [0, 7, 15, 22, 30].map do |day|
      progress = day / 30.0
      variation = trend * progress
      price = base_price * (1 + variation)
      # Ajoute une petite variation aléatoire à chaque point de contrôle
      price * (1 + rand(-0.05..0.05))
    end

    # Génère l'historique complet des prix
    prices = (0..30).map do |days_ago|
      date = (Date.today - days_ago).to_s

      # Trouve les points de contrôle qui encadrent le jour actuel
      segment_index = control_points.length.times.find { |i| days_ago <= (i * 7.5).floor } || 4
      start_point = control_points[segment_index - 1]
      end_point = control_points[segment_index]

      # Calcule la progression dans le segment actuel
      segment_progress = (days_ago % 7.5) / 7.5

      # Interpole le prix entre les points de contrôle
      base = start_point + (end_point - start_point) * segment_progress

      # Ajoute une très petite variation quotidienne (-1% à +1%)
      daily_variation = rand(-0.01..0.01)
      price = base * (1 + daily_variation)

      # Arrondit à 2 décimales
      {
        date: date,
        price: price.round(2)
      }
    end

    # Applique un lissage final pour éviter les variations trop brusques
    smoothed_prices = prices.each_cons(3).map do |prev, current, next_price|
      if prev && next_price
        current[:price] = ((prev[:price] + current[:price] + next_price[:price]) / 3.0).round(2)
      end
      current
    end

    # Ajoute le premier et dernier prix qui n'ont pas été lissés
    [prices.first] + smoothed_prices + [prices.last]
  end
end
