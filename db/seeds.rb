require 'faker'

# Drop the DB first
Mentor.delete_all
Mentor.destroy_all
User.delete_all
User.destroy_all


# Creating test user
user = User.new
user.email = 'test@test.com'
user.password = 'password'
user.save!

# Seeding multiple users
