class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]

  def create
    #TODO: @post_comment を作成してDBに登録後 post_path に遷移  `4行目は@postにする？`
    @post = Post.find(params[:post_id])
    @post_comment = current_user.post_comments.build(post_comment_params.merge(post_id: params[:post_id]))
    if @post_comment.save
      #redirect_to post_path(params[:id])
      flash[:notice] = "コメントを投稿しました"
      redirect_to post_path(@post)
    else
      @user = @post.user
      @new_post = Post.new
      @post_comments = @post.post_comments
      flash.now[:alert] = "コメントの投稿に失敗しました"
      render "public/posts/show"
    end
   end

  def index
    @post_comments = Post_comments.all
  end

  def destroy
    @post = @post_comment.post
    @post_comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to post_path(@post)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:body)
  end

  def correct_user
    @post_comment = current_user.post_comments.find_by_id(params[:id])
    redirect_to root_url if !@post_comment
  end
end
