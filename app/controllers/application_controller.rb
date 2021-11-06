class ApplicationController < ActionController::Base
  before_action :initialize_user_array

  def hello
  end
  private
  def configure_devise_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :password])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:user_name, :password])
  end

  def initialize_user_array 
    if user_signed_in?
      if current_user.voted_comment_ids.nil?
        current_user.voted_comment_ids = []
      end
      if current_user.voted_contribution_ids.nil?
        current_user.voted_contribution_ids = []
      end
      current_user.save 
    end
  end
end
