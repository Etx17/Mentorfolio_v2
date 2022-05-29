class MeetingsController < ApplicationController

  def new
    @user = current_user
    @meeting = Meeting.new
  end

  def create
    @user = current_user
    @meeting = Meeting.new(params[:status, :mentor])
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
    @mentor = Mentor.find_by(user: current_user)
  end

  def update
    p ' LETS UPDATE '
    @user = current_user
    @meeting = Meeting.find(params[:id])
    @mentor = Mentor.find_by(user: current_user)
    p "-> MENTOR ID BEFORE UPDATE:#{@meeting.mentor.id}"
    if @meeting.update(mentor: @mentor) && @meeting.update(status: 1)
      p "-> MENTOR ID AFTER UPDATE:#{@meeting.mentor.id} ; STATUS: #{@meeting.status}"
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
  #   @meeting.update(params[:status, :mentor])
  #   @meeting.save

  #   redirect_to dashboard_path
  # end

  private

  def meeting_params
    params.require(:meeting).permit(:start_time, :user, :mentor, :status)
  end
end
