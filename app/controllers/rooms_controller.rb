require 'tempfile'
require 'csv'
class RoomsController < ApplicationController
  before_action :authenticate_user!
  def index
    @rooms = Room.all
    @user = User.find(params[:user_id])
  end

  def create
    @room = Room.create(params_room)
    if @room.save
      flash[:notice] = "Okay :)"
    else
      flash[:alert] = "Oh no !!"
    end
    redirect_to user_rooms_path(current_user)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.room_messages
    @user = User.find(params[:user_id])
    respond_to :js
  end

  def edit
    @room = Room.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(params_room)
      flash[:notice] = "It's edited sucessfully"
    else
      flash[:alert] = "Oh Nooo !!!"
    end
  end

  def destroy
    @room = Room.find(params[:id])
    if @room
      if @room.destroy
        flash[:notice] = "Okay :)"
      else
        flash[:alert] = "Oh no !!"
      end
    else
      flash[:alert] = "Conversation does not existed"
    end
    redirect_to user_rooms_path
  end

  def download
    @messages = RoomMessage.all
    test_file = Tempfile.new("TestFile.csv")
    header = ["Users", "Messages"]
    CSV.open(test_file, "wb", headers: header ) do |writer|
      @messages.each do |element|
        writer << [element.messages, element.user.name]
      end
    end
    test_file.rewind
    File.open(test_file.path, "r") do |f|
      send_data(f.read, filename: "TestFile.csv")
    end
    File.delete(test_file.path)
    test_file.close
    test_file.unlink
  end

  private
  def params_room
    params.permit(:name, :user_id)
  end
end