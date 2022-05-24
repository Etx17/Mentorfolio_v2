class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def about
  end

  def mentors
    @mentors = Mentor.all
  end

  def dashboard
    @user = current_user
    if current_user.role = "mentor"
      @mentor = Mentor.where(user_id: current_user.id)
      @bookings_as_mentor = Booking.where(mentor_id: @mentor)
    end
  end

  def profile
    @user = current_user
  end
end
