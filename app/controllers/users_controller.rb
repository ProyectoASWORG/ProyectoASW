class UsersController < ApplicationController
  before_action :set_user, only: [:update, :edit, :show]

  before_action :get_user, only: [:edit, :update]

  #GET /users/1
  #GET /users/1.json
  def show
    respond_to do |format|
      if @usuario.nil?
        format.html { redirect_to :contributions,  notice: "The user not exists" }
        format.json { render json: {
            error: 'user not found',
            status: :not_found
          }, status: :not_found
          }
      else
        format.html { render :show, status: :ok }
        format.json { render json: {
          user: @usuario,
          status: :ok
        }, status: :ok
        }
      end
    end
  end

  def edit
    respond_to do |format|
      #comporbar usuario autorizado
      if @user.nil?
          format.html { redirect_to :contributions, notice: 'You need to be logged in to edit your profile', status: :unauthorized }
          format.json { render json: {
              error: "user not found",
              status: :unauthorized
            }, status: :unauthorized
          }
      else
        if @usuario.nil?
        #comprobar que el usuario a modificar existe
        format.html { redirect_to :contributions, notice: "The user that you're trying to edit does not exist", status: :not_found }
        format.json { render json: {
            error: "user not found",
            status: :not_found
          }, status: :not_found
        }
        else
          #comprobar que el usuario autorizado y el que se quiere actualizar son el mismo
          if @usuario.id == @user.id
            format.html { render :edit }
            format.json { render json: {
                msg: "user edited",
                status: :ok,
                user: @usuario 
              }, status: :ok
            }
          #el usuario autorizado y el que se quiere actualizar no son el mismo
          else
            format.html { redirect_to users_show_url(@usuario) }
            format.json { render json: {
                error: "Authorized user does not match with updatable user",
                status: unprocessable_entity
              }, status: unprocessable_entity
            }
          end
        end
      end
    end
  end


  def update 
    respond_to do |format|
      #comprobar usuario autorizado
      if @user.nil?
          format.html { redirect_to :contributions, notice: 'You need to be logged in to update your profile', status: :unauthorized }
          format.json { render json: {
              error: "user not authenticated",
              status: :unauthorized
            }, status: :unauthorized
          }
      else
        if @usuario.nil?
        #comprobar que el usuario a modificar existe
        format.html { redirect_to :contributions, notice: "The user that you're trying to upadte does not exist", status: :not_found }
        format.json { render json: {
            error: "user not found",
            status: :not_found
          }, status: :not_found
        }
        else
          #comprobar que el usuario autorizado y el que se quiere actualizar son el mismo
          if @usuario.id == @user.id and @usuario.update(user_params)
            format.html { redirect_to users_edit_url(@usuario)}
            format.json { render json:{
                msg: "user updated", 
                user: @usuario
              }, status: :ok
            }
          #el usuario autorizado y el que se quiere actualizar no son el mismo
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
  end

  private
  def user_params
    params.require(:user).permit(:about, :email, :max_visit, :min_away, :delay, :show_dead, :no_procrast)
  end

  def set_user
    begin
      @usuario = User.find(params[:id])
    rescue
      @usuario = nil
    end
  end

end
