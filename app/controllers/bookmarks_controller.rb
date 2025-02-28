class BookmarksController < ApplicationController
  before_action :set_list

  def create
    @bookmark = @list.bookmarks.new(bookmark_params)
    if @bookmark.save
      redirect_to @list, notice: '✅ Movie added successfully!'
    else
      flash[:alert] = @bookmark.errors.full_messages.to_sentence
      redirect_to @list
    end
  end

  def destroy
    @bookmark = @list.bookmarks.find(params[:id])
    if @bookmark.destroy
      redirect_to @list, notice: '🗑 Bookmark deleted!'
    else
      redirect_to @list, alert: @bookmark.errors.full_messages.to_sentence
    end
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
