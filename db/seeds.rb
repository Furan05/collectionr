# db/seeds.rb
require 'faker'
# Nettoyage de la base de données existante
puts "Cleaning database..."
Collection.destroy_all
puts "Collections destroyed"
User.destroy_all
puts "Users destroyed"
Card.destroy_all
puts "Cards destroyed"

puts "Create User"
User.create!(first_name: "Admin", last_name: "Admin", email: "admin@admin.com", password: "0123456")
10.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "password"
  )
  puts "Created user: #{user.first_name}"
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
      set: card.set.name
    )
    print "." # Progress indicator
  end

  puts "\nCreated #{sword_shield_cards.count} Sword & Shield cards!"
rescue => e
  puts "Error fetching Sword & Shield cards: #{e.message}"
end

begin
  # Get all cards from Sword & Shield set
  base1_cards = Pokemon::Card.where(q: 'set.id:base1')

  base1_cards.each do |card|
    Card.create!(
      name: card.name,
      tcg: "pokemon",
      tcg_id: card.id,
      image: card.images.small,
      set: card.set.name
    )
    print "." # Progress indicator
  end

  puts "\nCreated #{base1.count} Sword & Shield cards!"
rescue => e
  puts "Error fetching Sword & Shield cards: #{e.message}"
end

puts "Created #{Card.count} cards!"


# Récupérer le set Sword & Shield
sword = Pokemon::Set.all.find { |set| set.id == "swsh1" }
base1 = Pokemon::Set.all.find { |set| set.id == "base1" }
# sv8 = Pokemon::Set.all.find { |set| set.id == "sv8" }

# Créer une collection pour chaque utilisateur
User.all.each do |user|
  Collection.create!(
    title: sword.name,
    user_id: user.id,
    image_url: sword.images.logo
  )
  Collection.create!(
    title: base1.name,
    user_id: user.id,
    image_url: base1.images.logo
  )
end

puts "Created #{Collection.count} collections for #{User.count} users!"
