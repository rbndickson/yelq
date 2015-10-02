# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cafe = Category.create!(name: 'Cafe')
restaurant = Category.create!(name: 'Restaurant')

Business.create!(
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

Business.create!(
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

Business.create!(
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
