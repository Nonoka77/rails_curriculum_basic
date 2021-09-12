class Admin::BoardsController < ApplicationController
before_action :set_board, only: %i[edit destroy update show]
    before_action :require_login
    def index
        @q = Board.ransack(params[:q])
        @boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
    end

    def new
        @board = Board.new
    end

    def edit; end

    def show; end


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
        redirect_to admin_boards_path, success: t('.success', item: Board.model_name.human)
    end
    
    private

    def set_board
        @board = Board.find(params[:id])
    end

    def board_params
        params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
    end
end