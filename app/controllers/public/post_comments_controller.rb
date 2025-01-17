class Public::PostCommentsController < ApplicationController
  def create
    #TODO: @post_comment を作成してDBに登録後 post_path に遷移  `4行目は@postにする？`
    @post = Post.find(params[:post_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    post_comment.save
    redirect_to post_path

  end

  def destroy
    #TODO: 自分のコメントだけが削除できるように
    PostComment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
