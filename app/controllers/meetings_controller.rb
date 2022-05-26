class MeetingsController < ApplicationController
  def new
    @meeting = Meeting.new
  end


  def create
    @user = current_user
    @meeting = Meeting.new(meeting_params)
    @meeting.user = @user
    @meeting.status = 0
    if @meeting.save
      flash.success = "You'r request has been sent. A mentor will confirm your request soon. "
      redirect_to dashboard_path
    else
      flash.alert = "An error occured"
      render :new
    end
  end

  private

  def meeting_params
    params.require(:meeting).permit(:start_date, :status)
  end
end
