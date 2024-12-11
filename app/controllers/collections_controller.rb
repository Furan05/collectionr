class CollectionsController < ApplicationController
  def index
    begin
      # Récupérer tous les sets via l'API Pokémon TCG SDK
      @sets = Pokemon::Set.all.sort_by { |set| set.release_date }.reverse
    rescue StandardError => e
      @sets = []
      flash[:alert] = "Une erreur est survenue lors de la récupération des sets : #{e.message}"
    end
  end
end
