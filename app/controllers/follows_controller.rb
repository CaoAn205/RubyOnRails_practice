class FollowsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @follows = User.joins(:follows).where(id: @user.id)
    @followeds = User.joins(:followeds).where(id: @user.id)
  end

  def create
    @follow = current_user.follows.create
    @user = User.find(params[:user_id])
    if @follow.save
      # redirect_to user_path(params[:user_id])
      @followed = @follow.create_followed(user_id: params[:user_id])
      respond_to :js
    else
      redirect_to root_path
    end
  end

  def destroy
    # @follow = Follow.where(user_id: current_user.id)
    @follow = Follow.find(params[:id])
    @followed = @follow.followed
    if @followed
      @user = User.find(@followed.user_id)
      if @follow.destroy
        @follow.destroy
        # redirect_to user_path(params[:id])
        respond_to :js
      end
    end
  end
end
