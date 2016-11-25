# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do
  User.create(
  	email: Faker::Internet.email,
  	password: "123456"
  	)
  puts "Created 1 user"
end

User.all.each do |user|
	5.times do
		user.listings.create(
			country: Faker::Address.country,
	    	city_town: Faker::Address.city,
	    	home_type: Faker::Lorem.word,
	    	guest: rand(1..6),
	    	description: Faker::Lorem.paragraph(2),
	    	price: rand(50..500),
	    	property_name: Faker::StarWars.character,
	    	)
		puts "Created 1 listing"
	end
end