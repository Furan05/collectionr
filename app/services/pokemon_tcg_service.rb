class PokemonTcgService
  include HTTParty
  base_uri 'https://api.pokemontcg.io/v2'

  def initialize(api_key = nil)
    @api_key = api_key || ENV['POKEMON_TCG_API_KEY']
  end

  def get_card_info(tcg_id)
    response = self.class.get("/cards", {
      query: { q: "id:#{tcg_id}" },
      headers: { "X-Api-Key" => @api_key }
    })

    JSON.parse(response.body)["data"].first if response.success?
  end
end
