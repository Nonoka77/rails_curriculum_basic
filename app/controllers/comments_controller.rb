class CommentsController < ActionController::Base
    def create
        comment = current_user.comments.build(comment_params)
        if comment.save
            redirect_to board_path(comment.board)
            flash[:success] = t('comments.create.success')
        else
            flash[:danger] = t('comments.create.fail')
            redirect_to board_path(comment.board)
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:body).merge(board_id: params[:board_id])
    end
end
