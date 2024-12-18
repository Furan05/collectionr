# db/seeds.rb
require 'faker'
# Nettoyage de la base de données existante
puts "Cleaning database..."
Achat.destroy_all
puts "Achats destroyed..."
# Destroy in correct order - children first
CollectionType.destroy_all
puts "Collection Types destroyed"
Collection.destroy_all
puts "Collections destroyed"
Card.destroy_all
puts "Cards destroyed"
User.destroy_all
puts "Users destroyed"

puts "Create User"
User.create!(first_name: "Admin", last_name: "Admin", email: "admin@admin.com", password: "0123456", pays: "France", city: "Paris", address: "1 rue de Paris", postal_code: "75000")
10.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "password",
    pays: Faker::Address.country,
    city: Faker::Address.city,
    address: Faker::Address.street_address,
    postal_code: Faker::Address.zip_code
  )
  puts "Created user: #{user.first_name} #{user.city}"
end

# Création des cartes
puts "Creating cards..."
begin
  # Get all cards from Sword & Shield set
  sword_shield_cards = Pokemon::Card.where(q: 'set.id:swsh1')

  sword_shield_cards.each do |card|
    Card.create!(
      name: card.name,
      tcg: "pokemon",
      tcg_id: card.id,
      image: card.images.small,
      set: card.set.name,
      set_logo: card.set.images.symbol
    )
    print "." # Progress indicator
  end

  puts "\nCreated #{sword_shield_cards.count} Sword & Shield cards!"
rescue => e
  puts "Error fetching Sword & Shield cards: #{e.message}"
end

begin
  # Get all cards from Base 1 set
  base1_cards = Pokemon::Card.where(q: 'set.id:base1')

  base1_cards.each do |card|
    Card.create!(
      name: card.name,
      tcg: "pokemon",
      tcg_id: card.id,
      image: card.images.small,
      set: card.set.name,
     set_logo: card.set.images.symbol
    )
    print "." # Progress indicator
  end

  puts "\nCreated #{base1_cards.count} Base 1 cards!"
rescue => e
  puts "Error fetching Base 1 cards: #{e.message}"
end

begin
  # Get all cards from Scarlet & Violet set
  surging_sparks_cards = Pokemon::Card.where(q: 'set.id:sv8')

  surging_sparks_cards.each do |card|
    Card.create!(
      name: card.name,
      tcg: "pokemon",
      tcg_id: card.id,
      image: card.images.small,
      set: card.set.name,
     set_logo: card.set.images.symbol
    )
    print "." # Progress indicator
  end

  puts "\nCreated #{surging_sparks_cards.count} Scarlet & Violet cards!"
rescue => e
  puts "Error fetching Scarlet & Violet cards: #{e.message}"
end

begin
  # Get all cards from Neo Genesis set
  neo_genesis_cards = Pokemon::Card.where(q: 'set.id:neo1')

  neo_genesis_cards.each do |card|
    Card.create!(
      name: card.name,
      tcg: "pokemon",
      tcg_id: card.id,
      image: card.images.small,
      set: card.set.name,
    set_logo: card.set.images.symbol
    )
    print "." # Progress indicator
  end

  puts "\nCreated #{neo_genesis_cards.count} neo genesis cards!"
rescue => e
  puts "Error fetching neo genesis cards: #{e.message}"
end

puts "Created #{Card.count} cards!"

# Récupérer le set Sword & Shield
sword = Pokemon::Set.all.find { |set| set.id == "swsh1" }
base1 = Pokemon::Set.all.find { |set| set.id == "base1" }
sv8 = Pokemon::Set.all.find { |set| set.id == "sv8" }
neo1 = Pokemon::Set.all.find { |set| set.id == "neo1" }

# Créer une collection pour chaque utilisateur
User.all.each do |user|
  Collection.create!(
    title: sword.name,
    user_id: user.id,
    image_url: sword.images.logo,
    tcg: "pokemon",
    release_date: sword.release_date  # Added tcg field
  )
  Collection.create!(
    title: base1.name,
    user_id: user.id,
    image_url: base1.images.logo,
    tcg: "pokemon",
    release_date: base1.release_date  # Added tcg field
  )
  Collection.create!(
    title: sv8.name,
    user_id: user.id,
    image_url: sv8.images.logo,
    tcg: "pokemon",
    release_date: sv8.release_date  # Added tcg field
  )
  Collection.create!(
    title: neo1.name,
    user_id: user.id,
    image_url: neo1.images.logo,
    tcg: "pokemon",
    release_date: neo1.release_date  # Added tcg field
  )
end

puts "Created #{Collection.count} collections for #{User.count} users!"



puts "Creating YuGiOh collections and cards..."

# YuGiOh sets data
yugioh_sets = [
  {
    name: "Legend of Blue Eyes White Dragon",
    set_code: "LOB",
    release_date: "2002-03-08"
  },
  {
    name: "Metal Raiders",
    set_code: "MRD",
    release_date: "2002-06-26"
  },
  {
    name: "Dawn of Majesty",
    set_code: "DAMA",
    release_date: "2021-08-12"
  },
  {
    name: "2022 Tin of the Pharaoh's Gods",
    set_code: "MP22",
    release_date: "2022-09-14"
  }
]

# Fetch all YuGiOh sets data first
puts "Fetching YuGiOh sets data..."
sets_response = HTTParty.get("https://db.ygoprodeck.com/api/v7/cardsets.php")

if sets_response.success?
  all_sets = JSON.parse(sets_response.body)

  User.all.each do |user|
    puts "\nCreating collections for user: #{user.email}"

    yugioh_sets.each do |set_data|
      # Find matching set from API response
      api_set = all_sets.find { |s| s["set_name"] == set_data[:name] }

      if api_set
        collection = Collection.create!(
          title: set_data[:name],
          user: user,
          image_url: api_set["set_image"],
          tcg: "yugiho",
          release_date: set_data[:release_date]
        )
        puts "Created collection: #{collection.title}"

        # Fetch cards for this set
        cards_response = HTTParty.get("https://db.ygoprodeck.com/api/v7/cardinfo.php",
          query: { cardset: set_data[:name] }
        )

        if cards_response.success?
          cards_data = JSON.parse(cards_response.body)["data"]

          cards_data.each do |card_data|
            card = Card.where(
              tcg_id: card_data["id"].to_s,
              tcg: "yugiho"
            ).first_or_create!(
              name: card_data["name"],
              image: card_data["card_images"][0]["image_url"],
              set: set_data[:name]
            )
            print "."
          end
          puts "\nCreated/linked #{cards_data.length} cards for #{set_data[:name]}!"
        else
          puts "Error fetching cards for #{set_data[:name]}: #{cards_response.code}"
        end
      else
        puts "Set not found in API: #{set_data[:name]}"
      end
    end
  end
else
  puts "Failed to fetch YuGiOh sets data: #{sets_response.code}"
end

puts "Adding cards to collections..."
User.all.each do |user|
  user.collections.each do |collection|
    total_set_cards = Card.where(set: collection.title).count
    # Add random number of cards between 5 and total set cards
    rand(5..total_set_cards).times do
      card = Card.where(set: collection.title).sample
      CollectionType.create!(
        collection_id: collection.id,
        card_id: card.id,
        tcg: card.tcg # or collection.tcg
      )
    end
    puts "Added #{collection.cards.count} cards to #{collection.title}"
  end
end

# Créer une liste d'offre random entre 1 à 10 par User
puts "\nCreating offers..."
User.all.each do |user|
  owned_cards = user.cards.distinct

  rand(0..7).times do
    card = owned_cards.sample
    next unless card

    Offer.create!(
      title: card.name,
      price: rand(1..1000),
      condition: Offer::CONDITION.sample,
      graduation: Offer::GRADUATE.sample,
      langue: ['English', 'French', 'Japanese'].sample,
      image_url: card.image,
      user_id: user.id,
      card_id: card.id
    )
  end
  puts "Created #{user.offers.count} offers for #{user.first_name}"
end


puts "\nSeeding completed!"
