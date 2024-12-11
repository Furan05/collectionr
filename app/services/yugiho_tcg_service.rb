class YugihoTcgService
  include HTTParty
  base_uri 'https://db.ygoprodeck.com/api/v7'

  # def initialize(api_key = nil)
  #   @api_key = api_key || ENV['POKEMON_TCG_API_KEY']
  # end

  def get_card_info(tcg_id)
    response = self.class.get("/cardinfo.php", {
      query: { q: "id:#{tcg_id}" },
      # headers: { "X-Api-Key" => @api_key }
    })

    JSON.parse(response.body)["data"].first if response.success?
  end
end
