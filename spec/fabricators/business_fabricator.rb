Fabricator(:business) do
  name { Faker::Company.name }
  address { Faker::Address.street_address }
  city { Faker::Address.city }
  country { ["United Kingdom", "United States", "Japan", "Germany"].sample }
end
