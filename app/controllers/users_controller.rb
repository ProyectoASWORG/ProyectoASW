class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def update

  end

  private
  def contribution_params
    params.require(:user).permit(:user_name)
  end

end
