class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token 

  def hello
  end

  def encode_token(user_id)
    exp = Time.now.to_i + (4 * 3600)
    jwt_payload = {
      user_id: user_id,
      exp: exp
    }
    JWT.encode jwt_payload, "secreto", 'HS256'
  end

  def auth_header
    header = request.headers['Authorization']
    if header.nil?
      header = params[:token]
      if header.include? ".json"
        @format = "json"
        header.slice! ".json"
      end
    else 
      header = header.split(' ').last
    end
    return header
  end

  def decoded_token
    header = auth_header
    JWT.decode header, "secreto", true, { verify_iat: true, algorithm: 'HS256' }
  end

  def get_user 
      begin
        auth_token = decoded_token         
        user_id = auth_token[0]["user_id"]
        @user = User.find(user_id)
      rescue 
        @user = nil
      end
  end
end
