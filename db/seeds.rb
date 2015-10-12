# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cafe = Category.create!(name: 'Cafe')
restaurant = Category.create!(name: 'Restaurant')

bosanska = Business.create!(
  name: 'Cafe Bosanska',
  address: '22 Main Street',
  city: 'London',
  postcode: 'NW6 2EZ',
  country: 'United Kingdom',
  phone_number: '01234 555666',
  web_address: 'www.cafebosanska.com',
  category: cafe,
  main_picture_url: '/tmp/cafe_bosanska.jpg',
)

fruhstuck = Business.create!(
  name: 'Fruhstuck',
  address: '8 Neukolln Avenue',
  city: 'London',
  postcode: 'SW2 5MN',
  country: 'United Kingdom',
  phone_number: '09876 773321',
  web_address: 'www.fruhstuckisthebest.com',
  category: cafe,
  main_picture_url: '/tmp/fruhstuck.jpg',
)

suhs = Business.create!(
  name: "Suh's",
  address: '234 36th Street',
  city: 'Chicago',
  postcode: '60607',
  country: 'United States',
  phone_number: '312 111 222',
  web_address: 'www.suhsrestaurant.com',
  category: restaurant,
  main_picture_url: '/tmp/suhs.jpg',
)

alice = User.create!(
  first_name: "Alice",
  last_name: "Alicia",
  email: "alice.a@example.com",
  password: "password1",
)

bryan = User.create!(
  first_name: "Bryan",
  last_name: "Bryant",
  email: "bryan@example.com",
  password: "password2",
)

charlie = User.create!(
  first_name: "Charlie",
  last_name: "Chudleigh",
  email: "charlie.c@.com",
  password: "password3",
)

Review.create!(
  business: bosanska,
  creator: alice,
  rating: 4,
  content: "Great coffee and cakes!"
)

Review.create!(
  business: bosanska,
  creator: bryan,
  rating: 3,
  content: " Try the Turkish tea it was delicious."
)

Review.create!(
  business: fruhstuck,
  creator: charlie,
  rating: 5,
  content: "Lovely big breakfast and great value :)"
)

Review.create!(
  business: fruhstuck,
  creator: alice,
  rating: 5,
  content: "Excellent selection including vegetarian options. Recommended!"
)

Review.create!(
  business: suhs,
  creator: bryan,
  rating: 5,
  content: "Fantastic food and service!"
)
