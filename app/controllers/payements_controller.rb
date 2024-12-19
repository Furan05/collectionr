class PayementsController < ApplicationController
  def index
    @achats = current_user.achats.where(state: 'pending') # Get all pending purchases
  end
  def new
    @achat = current_user.achats.where(state: 'pending').find(params[:achat_id])
  end
end
