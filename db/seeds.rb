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

puts "Creating languages..."
Language.create!(name: "English")
Language.create!(name: "Japanese")
Language.create!(name: "Korean")
Language.create!(name: "Portuguese")
Language.create!(name: "Mandarin")
Language.create!(name: "Cantonese")
Language.create!(name: "Sinhalese")
Language.create!(name: "German")
Language.create!(name: "French")
Language.create!(name: "Russian")
Language.create!(name: "Spanish")
puts "Created languages."

puts "Creating user_language randomly for all users (All have English, + 1 random language)..."
User.all.each do |user|
  UserLanguage.create(user_id: user.id, language_id: Language.where(name: "English")[0].id)
  if user.username == "jamieheo"
    UserLanguage.create(user_id: user.id, language_id: Language.where(name: "Japanese")[0].id)
  else
    UserLanguage.create(user_id: user.id, language_id: Language.where.not(name: "English").sample.id)
  end
end
puts "Added language associations (English + random) to all users. Added English + Japanese to jamieheo"
