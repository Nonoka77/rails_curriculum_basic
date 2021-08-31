class BoardsController < ApplicationController
    def index
        @boards = Board.all.eager_load(:user).order(created_at: :desc)
    end

    def new
        @board = current_user.boards.new
    end

    def show
        @board = Board.find(params[:id])
    end

    def create
        @board = current_user.boards.new(board_params)
        if @board.save
            redirect_to boards_path, success: t('boards.new.success', item: Board.model_name.human)
        else
            flash.now[:danger] =  t('boards.new.fail', item: Board.model_name.human)
            render new_board_path
        end
    end
    
    private
    
    def board_params
        params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
    end
end