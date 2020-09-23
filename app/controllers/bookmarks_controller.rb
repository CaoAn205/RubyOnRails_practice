class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @bookmark =  current_user.bookmarks.build(params.permit :post_id)
    @post = @bookmark.post
    @is_bookmarked = @post.is_bookmarked(current_user)
    if @bookmark.save
      respond_to :js
      # flash[:notice] = "Okee"
    else
      flash[:alert] = "Something went wrong"
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @post = @bookmark.post
    if @bookmark.delete
        respond_to :js
        # flash[:notice] = "Deleted"
    else
        flash[:alert] = "Something went wrong"
    end
  end

end
