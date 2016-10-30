class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @user_friends = @user.friend
    @current_user_friends = current_user.friend
  end
end
