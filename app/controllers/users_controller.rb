class UsersController < ApplicationController
  before_action :set_user, only: [:update, :edit, :show]

  def edit
    puts "dentro de edit"
    puts @user.inspect
  end

  def show
  end

  def update 
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_edit_url(@user), notice: 'User was successfully updated.' }
        format.json { render :edit, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:about, :email, :max_visit, :min_away, :delay)
  end

  def set_user
    @user = User.find(params[:id])
    puts @user.inspect
  end

end
