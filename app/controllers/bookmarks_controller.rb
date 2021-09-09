class BookmarksController < ApplicationController
  before_action :require_login, only: %i[create destroy]
  def create
    @board = Board.find(params[:board_id])
    current_user.bookmark(@board)
  end

  def destroy
    @board = current_user.bookmarks.find_by(params[:id]).board
    current_user.unbookmark(@board)
  end
end
