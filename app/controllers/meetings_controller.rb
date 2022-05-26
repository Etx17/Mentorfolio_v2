class MeetingsController < ApplicationController
  def new
    @user = current_user
    @meeting = Meeting.new
  end


  def create
    @user = current_user
    @meeting = Meeting.new(meeting_params)
    @meeting.user = @user
    @meeting.status = 0
    # this first mentor is the test mentor, so nobody has the login. and we can update it
    @meeting.mentor = Mentor.first
    p "attempt to save meeting"
    if @meeting.save
      flash.alert = "Meeting created successfully. Wait for a mentor to answer your request"
      redirect_to dashboard_path
    else
      flash.alert = "An error occured. Please try again or contact contact@mentorfolio.com"
      render :new
    end
  end

  private

  def meeting_params
    params.require(:meeting).permit(:start_time, :user_id)
  end
end
