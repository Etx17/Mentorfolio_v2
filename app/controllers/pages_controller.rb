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
    if @user.role == "mentor"
      @mentor = Mentor.where(user: current_user)
      @messages = Message.where(mentor: @mentor)
      start_date = params.fetch(:start_date, Date.today).to_date
      @meetings = Meeting.where(start_time: start_date.beginning_of_week..start_date.end_of_week, mentor: @mentor)
      @pending_meetings = Meeting.where(status: 0)
    else
      @meetings = Meeting.where(user: current_user)
      @messages = Message.where(user: current_user)
      @validated_meeting = Meeting.where(user: current_user, status: "confirmed")
    end
  end

  def profile
    @user = current_user
  end
end
