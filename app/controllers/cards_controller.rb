# app/controllers/cards_controller.rb
class CardsController < ApplicationController
  # before_action :set_tcg_service

  def index
    @cards = if params[:query].present?
      Card.where("name ILIKE ?", "%#{params[:query]}%")
    else
      Card.all
    end

    @cards = @cards.limit(20)
  end

 # app/controllers/cards_controller.rb
def show
  @card = Card.find(params[:id])
  service = TcgService.new(@card.tcg)
  @card_info = service.get_card_info(@card.tcg_id)
end

  private

  # def set_tcg_service
  #   @tcg_service ||= TcgService.instance(params[:tcg] || 'yugiho')
  # end

  def generate_price_history(card_info)
    return [] unless card_info && card_info["cardmarket"]

    prices = card_info["cardmarket"]["prices"]
    avg1 = prices["averageSellPrice"] || prices["avg1"]
    avg7 = prices["avg7"]
    avg30 = prices["avg30"]

    (0..30).map do |days_ago|
      date = (Date.today - days_ago).to_s
      base_price = if days_ago == 0
                     avg1
                   elsif days_ago <= 7
                     avg1 + (avg7 - avg1) * (days_ago / 7.0)
                   else
                     avg7 + (avg30 - avg7) * ((days_ago - 7) / 23.0)
                   end

      variation_percent = rand(-15.0..15.0) / 100
      price = base_price * (1 + variation_percent)
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
