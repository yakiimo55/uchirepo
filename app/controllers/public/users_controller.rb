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

  def guest_login
    @user = User.find_or_initialize_by(email: 'guest@test.com')
    if @user.new_record?
      @user.assign_attributes(
        name: 'ゲスト',
        password: 'password'
      )
      @user.save
    end
    sign_in(@user)
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:address)
  end
end
