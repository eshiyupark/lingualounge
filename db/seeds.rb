require "faker"

puts "Deleting messages..."
Message.delete_all
puts "Deleting reviews..."
Review.delete_all
puts "Deleting friendships..."
Friendship.delete_all
puts "Deleting sessions..."
Session.delete_all
puts "Deleting user_languages..."
UserLanguage.delete_all
puts "Deleting languages..."
Language.delete_all
puts "Deleting users..."
User.delete_all
puts "Deleted all records."

puts "Creating 5 users..."
user_one = User.new(email: "johndoe@gmail.com", password: "secret", username: "johndoe", first_name: "John", last_name: "Doe", date_of_birth: "1994-04-03", gender: "male")
user_one.save
user_two = User.create!(email: "jamieheo@gmail.com", password: "secret", username: "jamieheo", first_name: "Jamie", last_name: "Heo", date_of_birth: "1994-04-03", gender: "female")
user_two.save
User.create!(email: "eshiyupark@gmail.com", password: "secret", username: "eshiyupark", first_name: "Eshiyu", last_name: "Park", date_of_birth: "1994-12-28", gender: "male")
User.create!(email: "ayanthisaparamadu@gmail.com", password: "secret", username: "ayanthisaparamadu", first_name: "Ayanthi", last_name: "Saparamadu", date_of_birth: "1994-04-03", gender: "female")
User.create!(email: "monicapham@gmail.com", password: "secret", username: "monicapham", first_name: "Monica", last_name: "Pham", date_of_birth: "1994-04-03", gender: "female")
puts "Created 5 users"

puts "Creating languages (English, Japanese, Korean, Spanish, Chinese)..."
Language.create!(name: "english")
Language.create!(name: "japanese")
Language.create!(name: "korean")
Language.create!(name: "spanish")
Language.create!(name: "chinese")
puts "Created 5 languages."

puts "Creating 1 friendship between johndoe and jamieheo..."
Friendship.create!(status: "pending", participant_one_id: user_one.id, participant_two_id: user_two.id)
puts "Created 1 friendship between johndoe (participant one) and jamieheo (participant two)"

puts "Creating user_language randomly for all users (All have English, + 1 random language)..."
User.all.each do |user|
  UserLanguage.create(user_id: user.id, language_id: Language.where(name: "english")[0].id)
  UserLanguage.create(user_id: user.id, language_id: Language.where.not(name: "english").sample.id)
end
puts "Added language association (English + random) to all users."
