class CommentsController < ActionController::Base
    before_action :require_login
    def create
        comment = current_user.comments.new(comment_params)
        if comment.save
            redirect_to board_path(comment.board)
            flash[:success] = t('.success')
        else
            redirect_to board_path(comment.board)
            flash[:danger] = t('.fail')
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:body).merge(board_id: params[:board_id])
    end
end
