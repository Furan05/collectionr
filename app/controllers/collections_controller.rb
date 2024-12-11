class CollectionsController < ApplicationController
  def index
    @sets = Collection.where(user: current_user)
  end
end
