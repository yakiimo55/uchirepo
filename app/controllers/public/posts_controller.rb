class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

  def index
    @post = Post.new
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @new_post = Post.new
    #TODO: Viewにコメントの一覧を表示する
    @post_comments = @post.post_comments
    #TODO: Viewに新規コメント投稿のフォームを設置する
  end

  def new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "success"
      redirect_to post_path(@post)
    else
      @posts = Post.all
      flash.now[:alert] = "failed"
      render 'public/posts/index'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :genre_id)
  end
end
