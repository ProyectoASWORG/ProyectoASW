class UsersController < ApplicationController
  before_action :set_user, only: [:update, :edit, :show]

  before_action :get_user, only: [:edit, :update]

  def edit
    respond_to do |format|
      if @user.nil?
        respond_to do |format|
          format.html { redirect_to :users, notice: 'You need to be logged in to edit your profile', status: :unauthorized }
          format.json {
            render json: {
              error: "user not found",
              status: :unauthorized
            }, status: :unauthorized
          }
        end
      else
        if @usuario.id == @user.id
          format.html { render :edit }
          format.json { render :edit, status: :ok, location: @user }
        else
          format.html { redirect_to users_show_url(@user) }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  #GET /users/1
  #GET /users/1.json
  def show
  end

  def update 
    respond_to do |format|
      #comprobar usuario autorizado
      if @user.nil?
          format.html { redirect_to :contributions, notice: 'You need to be logged in to update your profile', status: :unauthorized }
          format.json {
            render json: {
              error: "user not authenticated",
              status: :unauthorized
            }, status: :unauthorized
          }
        end
      elsif @usuario.nil?
        #comprobar que el usuario a modificar existe
        format.html { redirect_to :contributions, notice: "The user that you're trying to upadte does not exist", status: :not_found }
          format.json {
            render json: {
              error: "user not found",
              status: :not_found
            }, status: :not_found
          }
      else
        if @usuario.id == @user.id and @usuario.update(user_params)
          format.html { redirect_to users_edit_url(@usuario)}
          format.json {
            render json:{
              msg: "User updated", 
              user: @usuario
            }, status: :success
          }
        else
          format.html { render :edit }
          format.json { render json: {
            error: "Authorized user does not match with updatable user",
            status: unprocessable_entity
          }, status: unprocessable_entity
        }
        end
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:about, :email, :max_visit, :min_away, :delay, :show_dead, :no_procrast)
  end

  def set_user
    @usuario = User.find(params[:id])
  end

end
