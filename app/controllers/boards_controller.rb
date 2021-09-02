class BoardsController < ApplicationController
    def index
        @boards = Board.all.includes(:user).order(created_at: :desc)
    end

    def new
        @board = Board.new
    end

    def show
        @board = Board.find(params[:id])
        @comment = Comment.new
        @comments = @board.comments.includes(:user).order(created_at: :desc)
    end


    def create
        @board = current_user.boards.build(board_params)
        if @board.save
            redirect_to boards_path, success: t('boards.new.success', item: Board.model_name.human)
        else
            flash.now[:danger] =  t('boards.new.fail', item: Board.model_name.human)
            render new_board_path
        end
    end

    def destroy
        @board.destroy
        redirect_to boards_url, success: t('comments.destroy.success')
    end
    
    private

    def board_params
        params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
    end
end