class ApplicationController < ActionController::Base
  def hello
  end
  private
  def configure_devise_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :password])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:user_name, :password])
  end
end
