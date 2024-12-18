class PayementsController < ApplicationController
  def new
    @achat = current_user.achats.where(state: 'pending').find(params[:achat_id])
  end
end
