class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @search = User.search(params[:term])
    @user = User.find(params[:user_id])
    @room = Room.find(params[:room_id])
    respond_to :js
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @saved = Post.joins(:bookmarks).where("bookmarks.user_id = ?", current_user.id)
    @follow = Follow.joins("INNER JOIN followeds ON follows.id = followeds.follow_id").where(user_id: current_user.id)[0]
    @follows = User.joins(:follows).where(id: @user.id)
    @followeds = User.joins(:followeds).where(id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:name, :email, :avatar))
      flash[:notice] = "Success"
    else
      flash[:alert] = "Failed"
    end
    redirect_to user_pa th(@user)
  end

  def destroy
    @user = User.find(params[:id])
    if @user
      if @user.destroy
        flash[:notice] = "Byeeee"
      else
      flash[:alert] = "Something went wrong"
      end
    else
      flash[:alert] = "User does not existed"
    redirect_to root_path
    end
  end
end
