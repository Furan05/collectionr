# class CollectionsController < ApplicationController
#   def index
#     @pokemon_collections = Collection.where(Card.where(category: "pokemon"))
#     @yugioh_collections = Collection.where(category: "yugioh")
#   end

#   def show
#   end
# end

#chaque a acces aux collections
#id = current_user.id
#collection = Collection.where(user_id: id)
# class CollectionsController < ApplicationController
#   def pokemon_sets
#     begin
#       @sets = Pokemon::Set.all # Récupère tous les sets via l'API Pokémon TCG SDK
#     rescue StandardError => e
#       @sets = []
#       flash[:alert] = "Une erreur est survenue lors de la récupération des sets : #{e.message}"
#     end
#   end
# end

class CollectionsController < ApplicationController
  def pokemon_sets
    begin
      @sets = Pokemon::Set.all # Récupère tous les sets via l'API Pokémon TCG SDK
      @sets = @sets.sort_by { |set| set.release_date }.reverse # Trie par date décroissante
    rescue StandardError => e
      @sets = []
      flash[:alert] = "Une erreur est survenue lors de la récupération des sets : #{e.message}"
    end
  end
end

