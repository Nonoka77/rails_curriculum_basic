class CommentsController < ActionController::Base
    def create
        comment = current_user.comments.build(comment_params)
        if comment.save
            redirect_to board_path(comment.board)
            flash[:success] = t('comments.create.success')
        else
            redirect_to board_path(comment.board)
            flash[:danger] = t('comments.create.fail')
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:body).merge(board_id: params[:board_id])
    end
end
