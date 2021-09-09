class BoardsController < ApplicationController
    before_action :set_board, only: %i[edit destroy update]
    before_action :require_login
    def index
        @boards = Board.all.includes(:user).order(created_at: :desc).page(params[:page])
    end

    def new
        @board = Board.new
    end

    def edit; end

    def bookmarks
        @bookmark_boards = current_user.bookmark_boards.includes(:user).order(created_at: :desc).page(params[:page])
    end

    def show
        @board = Board.find(params[:id])
        @comment = Comment.new
        @comments = @board.comments.includes(:user).order(created_at: :desc)
    end


    def create
        @board = current_user.boards.new(board_params)
        if @board.save
            redirect_to boards_path, success: t('.success', item: Board.model_name.human)
        else
            render new_board_path
            flash.now[:danger] =  t('.fail', item: Board.model_name.human)
        end
    end

    def update
        if @board.update(board_params)
            redirect_to @board, success: t('.success', item: Board.model_name.human)
        else
            render :edit
            flash.now[:danger] = t('.fail', item: Board.model_name.human)
        end
    end

    def destroy
        @board.destroy!
        redirect_to boards_path, success: t('.success', item: Board.model_name.human)
    end
    
    private

    def set_board
        @board = current_user.boards.find(params[:id])
    end

    def board_params
        params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
    end
end