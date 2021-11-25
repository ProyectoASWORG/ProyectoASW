class UsersController < ApplicationController
  before_action :set_user, only: [:update, :edit, :show]

  before_action :get_user, only: [:edit, :update]

  def edit
    respond_to do |format|
      if user_signed_in? and current_user.id == @user.id
        format.html { render :edit }
        format.json { render :edit, status: :ok, location: @user }
      else
        format.html { redirect_to users_show_url(@user) }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  #GET /users/1
  #GET /users/1.json
  def show
  end

  def update 
    respond_to do |format|
      if @user.id == current_user.id and @user.update(user_params)
        format.html { redirect_to users_edit_url(@user)}
        format.json { render :edit, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:about, :email, :max_visit, :min_away, :delay, :show_dead, :no_procrast)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
