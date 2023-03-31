# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'


User.destroy_all
Category.destroy_all
Item.destroy_all


images = [
    Faker::LoremFlickr.image(size: "300x300", search_terms: ['nature']),
    Faker::LoremFlickr.image(size: "300x300", search_terms: ['city']),
    Faker::LoremFlickr.image(size: "300x300", search_terms: ['food']),
    # Ajoutez autant d'URLs d'images aléatoires que vous le souhaitez ici
  ]

20.times do
    user = User.create!(
      email: Faker::Internet.email,
      password: Faker::Internet.password
    )
  end
  categories = []

  15.times do
    category = Category.create!(
      name: Faker::Commerce.unique.department(max: 1)
    )
    categories << category
  end

  20.times do
    item = Item.create!(
      user_id: User.pluck(:id).sample,
      price: Faker::Commerce.price(range: 1..100.0, as_string: true),
      title: Faker::Commerce.product_name,

      description: Faker::Lorem.sentence(word_count: 10, random_words_to_add: 40)[0..15],
      category_id: categories.sample.id
    )
    file = URI.open(Faker::LoremFlickr.image(size: "600x600", search_terms: ['product']))
    item.photo.attach(io: file, filename: "#{Faker::Lorem.word}.png")
  end
 