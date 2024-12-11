class TcgService
  include HTTParty

  TCG_APIS = {
    'pokemon' => 'https://api.pokemontcg.io/v2',
    'yugiho' => 'https://db.ygoprodeck.com/api/v7'
  }

  # @@instances = {}

  # def self.instance(tcg)
  #   @@instances[tcg] ||= new(tcg)
  # end

  def initialize(tcg)
    @tcg = tcg.downcase
    @cache = {}
    # @api_key = ENV['POKEMON_TCG_API_KEY']
    self.class.base_uri TCG_APIS[@tcg]
  end

  def get_card_info(tcg_id)
    # Utilisez Rails.cache au lieu d'un cache en mémoire
    Rails.cache.fetch("card_info_#{@tcg}_#{tcg_id}", expires_in: 24.hours) do
      puts "Cache miss for #{@tcg} card #{tcg_id}" # Debug log
      start_time = Time.now

      result = case @tcg
      when 'pokemon'
        get_pokemon_card(tcg_id)
      when 'yugiho'
        get_yugiho_card(tcg_id)
      end

      puts "API call took #{Time.now - start_time} seconds" # Debug log
      result
    end
  end

  private

  def get_pokemon_card(tcg_id)
    response = self.class.get("/cards", {
      query: { q: "id:#{tcg_id}" },
      headers: {
        "X-Api-Key" => ENV['POKEMON_API_KEY'],
        'Accept' => 'application/json'
      }
    })

    handle_response(response)
  end

  def get_yugiho_card(tcg_id)
    puts "Requesting YuGiHo card: #{tcg_id}"
    response = self.class.get("/cardinfo.php", {
      query: { id: tcg_id.to_s },
      headers: { 'Accept' => 'application/json' }
    })

    handle_response(response)
  end

  def handle_response(response)
    if response.success?
      data = JSON.parse(response.body)
      data["data"]&.first
    else
      puts "API Error: #{response.code} - #{response.body}"
      nil
    end
  rescue => e
    puts "Exception: #{e.message}"
    nil
  end
end
