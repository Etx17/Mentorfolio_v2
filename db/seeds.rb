# date.to_fs(:short)         # => "10 Nov"
# date.to_fs(:number)        # => "20071110"
# date.to_fs(:long)          # => "November 10, 2007"
# date.to_fs(:long_ordinal)  # => "November 10th, 2007"
# date.to_fs(:rfc822)        # => "10 Nov 2007"
# date.to_fs(:iso8601)       # => "2007-11-10"

require 'faker'
# Drop the DB first
p "Deleting db..."
Meeting.delete_all
Mentor.delete_all
User.delete_all
# p "Deleting mentors was a succes. Deleting Users..."
# p "Users deleted"

p "Creating test user..."
# Creating test user
user = User.new
user.email = 'test@test.com'
user.password = 'password'
user.role = "mentor"
user.first_name = "Jean-Testphane"
user.last_name = "de la Testinière"
user.save!

# Making test user being a mentor
mentor = Mentor.new
mentor.user_id = User.first.id
mentor.save!
p "Test user created"

p "creating mentor@mentor.com and user@user.com"
mentor_user = User.create(email: "mentor@mentor.com", password:"password", role: "mentor")
user = User.create(email: "user@user.com", password: "password", role: "student")
mentor = Mentor.create(user: mentor_user)
meeting = Meeting.create(user: user, mentor: mentor)
message = Message.create(user: user, mentor: mentor, title: "Trouver son idée de produit", description: "Tu dois trouver une idée de produit à faire en portfolio qui ressemble par exemple à une boite que tu vises. Pourquoi toi qui voudrait bosser chez AirFrance, ne travaillerais tu pas sur un système de réservation quel qu'il soit ? Pour la prochaine fois : avoir trouvé ton idée et conceptualisé la base de donnée et toutes les features que tu veux.")
p "mentor, user, meeting and message created. Go on user@user or mentor@mentor to check."

p "Seeding 10 users"
i = 1
until i == 10 do
  user = User.new
  user.email = Faker::Internet.email
  user.password = 'password'
  user.role = 'student'
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.bio = Faker::Lorem.paragraphs
  user.save!
  p "user saved"

  meeting = Meeting.new
  meeting.user_id = User.last.id
  meeting.mentor_id = Mentor.first.id
  meeting.start_time = DateTime.now + (300 * i-1).minutes
  meeting.end_time = DateTime.now + (300 * i).minutes
  meeting.status = rand 3
  meeting.save!
  i += 1
end

# Creating a mentor based on a user
# mentor = Mentor.new
# mentor.user_id = User.first.id
# mentor.save!

# Associating the first 10 users with the first 10 mentors on a booking
# 6.times do
#   booking = Booking.new
#   booking.user_id = User.last.id
#   booking.mentor_id = Mentor.first.id
#   booking.start_date = Date.today
#   booking.end_date = Date.today + 10.days
#   booking.status = rand 3
#   booking.save!
# end
p "DB was seed successfully"
