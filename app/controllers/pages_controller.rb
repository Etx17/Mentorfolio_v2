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
      @mentor = Mentor.where(user_id: current_user.id)
      start_date = params.fetch(:start_date, Date.today).to_date
      @meetings = Meeting.where(start_time: start_date.beginning_of_week..start_date.end_of_week)
      @pending_meetings = Meeting.where(status: 0)
    else
      @meetings = Meeting.where(user: @user)
    end

  end

  def profile
    @user = current_user
  end
end
