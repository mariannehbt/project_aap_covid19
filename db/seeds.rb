# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Cmp.destroy_all

# cities = %w[Paris Bourges Nanterre]
# zipcodes = %w[75000 18000 92000]
# streets =  ["10 avenue du Général de Gaulle", "56 avenue du Général de Gaulle", "30 avenue Jean Jaurès", "10 avenue Jean Jaures", "50 rue Victor Hugo", "35 rue jean moulin","13 rue jean Moulin", "56 rue Jules Ferry", "3 rue Jules Ferry", "9 avenue du Marechal Foch"]
# j=0
# 10.times do
# 	i = [0,1,2].sample
#   cmp = Cmp.create(
#     street: streets[j],
#     zipcode: zipcodes[i],
#     phonenumber: Faker::PhoneNumber.phone_number,
#     name: Faker::Name.name, 
#     city: cities[i])
#   cmp.update(adress: cmp.street + ' ' + cmp.zipcode + ' ' + cmp.city)
#   j=j+1
# end

scraper = TestScrap.new
scraper.perform

i = 0
scraper.cmps_names_array.size.times do
	cmp = Cmp.create!(
		name: scraper.cmps_names_array[i],
		street: scraper.cmps_addresses_array[i],
		zipcode: scraper.cmps_locations_array[i],
		phonenumber: scraper.cmps_phone_numbers_array[i])
	cmp.update!(adress: cmp.street + ' ' + cmp.zipcode)
	i = i + 1
end
