class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all.includes(:photos, :user, :likes).order("created_at desc")
    @post = Post.create
  end

  def create
    @post = Post.create
    @post.user_id = current_user.id
    @post.content = params[:post][:content]
    if @post.save
      if params[:images].present?
        params[:images].each do |img|
          # debugger
          @post.photos.create(image: img[-1].original_filename)
          # Cloudinary::Uploader.upload(img[-1].original_filename)
        end
        flash[:notice] = "Saved"
      end
    else
        flash[:alert] = "Something went wrong"
    end
    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
    @likes = @post.likes
    @is_liked = @post.is_liked(current_user)
    @comment = @post.comments
    # debugger
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(params.require(:post).permit(:content))
      flash[:notice] = "Saved"
    else
      flash[:alert] = "Something went wrong"
    end
    redirect_to post_path
  end

  def destroy
    @post = Post.find(params[:id])
    if @post
      if @post.destroy
        flash[:notice] = "Deleted"
      else
        flash[:alert] = "Something went wrong"
      end
    else
      flash[:alert] = "Doesn't exist"
    end
    redirect_to posts_path
  end
end
