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
      redirect_to dashboard_path
    end
  end

  def edit
    @meeting = Meeting.find(params[:id])
    @user = current_user
    @mentor = Mentor.where(user: current_user)
  end

  def update
    @user = current_user
    @meeting = Meeting.find(params[:id])
    @mentor = Mentor.where(user: current_user)
    @meeting.status = 1
    p @meeting.mentor.id, "-> this is the mentor id before being updated"
    if @meeting.update(meeting_params)

      p @meeting.mentor.id, "-> this is the mentor id after being updated"

      p "the status of the meeting is now", @meeting.status
      flash.alert = "meeting saved successfully"
      redirect_to dashboard_path
    else
      flash.alert = "smth went wrong"
      redirect_to dashboard_path
    end
  end

  # def validate
  #   @meeting = Meeting.find(params[:id])
  #   @mentor = Mentor.where(user: current_user)
  #   # authorize @meeting
  #   @meeting.status = 1
  #   @meeting.update(meeting_params)
  #   @meeting.save

  #   redirect_to dashboard_path
  # end

  private

  def meeting_params
    params.require(:meeting).permit(:start_time, :user_id, :mentor_id, :status)
  end
end
