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
user.save!

# Making test user being a mentor
mentor = Mentor.new
mentor.user_id = User.first.id
mentor.save!
p "Test user created"

p "Seeding 10 users"
10.times do
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
  meeting.start_time = Date.today
  meeting.end_time = Date.today + 10.days
  meeting.status = rand 3
  meeting.save!
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
