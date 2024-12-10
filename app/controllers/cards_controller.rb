# app/controllers/cards_controller.rb
class CardsController < ApplicationController
  def index
    @cards = Card.all
  end
end
