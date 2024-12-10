# db/seeds.rb

# Nettoyage de la base de données existante
puts "Cleaning database..."
Card.destroy_all

# Création des cartes
puts "Creating cards..."

cards = [
  {
    name: "Ampharos",
    tcg: "pokemon",
    tcg_id: "dp3-1"
  },
  {
    name: "Aerodactyl",
    tcg: "pokemon",
    tcg_id: "ex12-1"
  },
  {
    name: "Caterpie",
    tcg: "pokemon",
    tcg_id: "mcd19-1"
  },
  {
    name: "Azumarill",
    tcg: "pokemon",
    tcg_id: "ex7-1"
  },
  {
    name: "Celebi & Venusaur-GX",
    tcg: "pokemon",
    tcg_id: "sm9-1"
  },
  {
    name: "Blastoise",
    tcg: "pokemon",
    tcg_id: "pl1-2"
  },
  {
    name: "Altaria",
    tcg: "pokemon",
    tcg_id: "ex3-2"
  },
  {
    name: "Weedle",
    tcg: "pokemon",
    tcg_id: "sm9-2"
  },
  {
    name: "Alolan Exeggutor",
    tcg: "pokemon",
    tcg_id: "mcd19-2"
  },
  {
    name: "Kakuna",
    tcg: "pokemon",
    tcg_id: "xy5-2"
  },
  {
    name: "Venusaur & Snivy-GX",
    tcg: "pokemon",
    tcg_id: "sm12-1"
  }
]

Card.create!(cards)

puts "Created #{Card.count} cards!"
