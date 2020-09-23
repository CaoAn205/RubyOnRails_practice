class RoomMessagesController < ApplicationController
  before_action :authenticate_user!
  def index
    @room = Room.find(params[:room_id])
    @user = User.find(params[:user_id])
    @room_messages = @room.room_messages
    # respond_to :js
  end

  def create
    @room = Room.find(params[:room_id])
    @user = User.find(params[:user_id])
    @room_message = RoomMessage.create(user_id: params[:user_id],
                                       room_id: params[:room_id],
                                       messages: params[:new_message])
    if @room_message.save
      @messages = @room.room_messages
      respond_to :js
    else
      flash[:alert] = "Something went wrong (again)"
    end
  end

  def destroy
    @room_message = RoomMessage.find(params[:id])
    if @room_message.destroy
      flash[:notice] = "OK"
      # respond_to :js
    else
      flash[:alert] = "Something went wrong (again)"
    end
  end
end