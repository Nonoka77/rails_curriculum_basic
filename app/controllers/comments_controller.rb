class CommentsController < ActionController::Base
  before_action :require_login, only: %i[create destroy]
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.save # ここで！を付けてしまうとエラーがページ上に表示されなくなってしまう
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(board_id: params[:board_id])
  end
end
