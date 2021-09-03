class BoardsController < ApplicationController
    before_action :set_board, only: %i[edit destroy update]
    def index
        @boards = Board.all.includes(:user).order(created_at: :desc)
    end

    def new
        @board = Board.new
    end

    def edit; end

    def show
        @board = Board.find(params[:id])
        @comment = Comment.new
        @comments = @board.comments.includes(:user).order(created_at: :desc)
    end


    def create
        @board = current_user.boards.new(board_params)
        if @board.save
            redirect_to boards_path, success: t('boards.new.success', item: Board.model_name.human)
        else
            render new_board_path
            flash.now[:danger] =  t('boards.new.fail', item: Board.model_name.human)
        end
    end

    def update
        if @board.update(board_params)
            redirect_to @board, success: t('boards.update.success', item: Board.model_name.human)
        else
            render :edit
            flash.now[:danger] = t('boards.update.fail', item: Board.model_name.human)
        end
    end

    def destroy
        @board.destroy!
        redirect_to boards_path, success: t('boards.destroy.success', item: Board.model_name.human)
    end
    
    private

    def set_board
        @board = current_user.boards.find(params[:id])
    end

    def board_params
        params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
    end
end