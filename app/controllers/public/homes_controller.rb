class Public::HomesController < ApplicationController
  def top
    redirect_to posts_path if current_user
  end

  def about
  end
end
