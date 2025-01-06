class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params) 
      flash[:notice] = "success"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "failed"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:address)
  end
end
