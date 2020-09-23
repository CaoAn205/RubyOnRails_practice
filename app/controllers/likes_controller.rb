class LikesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @like =  current_user.likes.build(params.permit :post_id)
    @post = @like.post
    if @like.save
      respond_to :js
    else
      flash[:alert] = "Something went wrong"
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @post = @like.post
    if @like.user_id = current_user.id
      if @like.delete
        respond_to :js
      else
        flash[:alert] = "Something went wrong"
      end
    else
      flash[:alert] = "You're not allowed to unlike it!"
    end
  end
end
