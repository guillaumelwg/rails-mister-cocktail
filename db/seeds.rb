# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

puts "Cleaning database..."
Cocktail.destroy_all
Ingredient.destroy_all

puts "Creating cocktails"

10.times do |cocktail|
  url = 'https://www.thecocktaildb.com/api/json/v1/1/random.php'
  cocktail_serialized = open(url).read
  cocktail = JSON.parse(cocktail_serialized)
  cocktail_attributes = cocktail['drinks'][0]
  cocktail_name = cocktail_attributes['strDrink']
  cocktail_photo_url = cocktail_attributes['strDrinkThumb']
  cocktail = Cocktail.create(name: cocktail_name, photo_url: cocktail_photo_url)
  puts "Created #{cocktail.name}"
end

puts "Finished"

puts "-----------------------------------------------"

ingredients_url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_serialized = open(ingredients_url).read
ingredients = JSON.parse(ingredients_serialized)

puts "Creating Ingredients"

i = 0
while i < 10
  ingredient_name = ingredients['drinks'][i]['strIngredient1']
  ingredient = Ingredient.create(name: ingredient_name)
  puts "Created #{ingredient.name}"
  i += 1
end

puts "Finished"
# Ingredient.create(name: "lemon")
# Ingredient.create(name: "ice")
# Ingredient.create(name: "mint leaves")
# Ingredient.create(name: "rhum")
# Ingredient.create(name: "gin")
