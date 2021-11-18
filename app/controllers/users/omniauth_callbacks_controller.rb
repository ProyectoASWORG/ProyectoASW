class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    user = User.from_google(from_google_params)
    
    jwt_payload = { user_id: user.id }
    
    token = JWT.encode jwt_payload, "secreto", 'HS256'
    
    if user.present?
      sign_out_all_scopes
      flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in user 
      current_user.token = token
      current_user.save
      respond_to do |format|
        format.html { redirect_to contributions_path }
        format.json { render :json => token }
      end
      return
    else
      flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
      redirect_to new_user_session_path
      return
    end
  end

  protected

  def after_omniauth_failure_path_for(_scope)
    redirect_to contributions_path 
    return
  end

  def after_sign_in_path_for(resource_or_scope)
    redirect_to contributions_path 
    return
  end

  private

  def from_google_params
    @from_google_params ||= {
      uid: auth.uid,
      email: auth.info.email,
      full_name: auth.info.name,
      avatar_url: auth.info.image
    }
  end

  def auth
    @auth ||= request.env['omniauth.auth']
  end
end