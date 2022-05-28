class MessagesController < ApplicationController
  def index
    if current_user.role == "student"
      @messages = Message.where(user: current_user)
    else
      @mentor = Mentor.find(user: current_user)
      @messages = Message.where(mentor: @mentor)
    end
  end

  def new
    @mentor = Mentor.find(user: current_user)
    @meeting = Meeting.find(params[:id])
    @student = @meeting.user
    @message = Message.new
    @message.user = @student
    @message.mentor = @mentor
  end

  def create
    @mentor = Mentor.find(user: current_user)
    @meeting = Meeting.find(params[:id])
    @student = @meeting.user
    @message = Message.new(message_params)
    if @message.save
      flash.alert = "Message sent successfully. Your student will be notified."
      redirect_to dashboard_path
    else
      flash.alert = "Sorry, something went wrong. Please try again"
      render :new
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

  def message_params
    params.require(:message).permit(:user, :mentor, :title, :description)
  end
end
