class BookmarksController < ApplicationController
  def create
    board = Board.find(params[:board_id])
    current_user.bookmark(board)
    if current_user.bookmark?(board)
      redirect_to request.referer, success: t('.success')
    else
      redirect_to request.referer
    end
  end

  def destroy
    board = current_user.bookmarks.find(params[:id]).board
    current_user.unbookmark(board)
    redirect_to boards_path, success: t('.success')
  end

end
