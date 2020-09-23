class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @comment = Comment.create
    # debugger
    @comments = Post.find(params[:post_id]).comments.include(:user)
  end

  def create
    @comment = Comment.create
    @comment.user_id = current_user.id
    @comment.post_id = params[:comment][:post_id]
    @comment.content = params[:comment][:content]
    @post = @comment.post
    if @comment.save
      respond_to :js
    else
      flash[:alert] = "Something went wrong"
    end
    # redirect_to post_path(@post)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    if @comment
      if @comment.delete
        respond_to :js
      else
        flash[:alert] = "Something went wrong"
      end
    else
      flash[:alert] = "Comment doesn't exist"
    end
  end
end
