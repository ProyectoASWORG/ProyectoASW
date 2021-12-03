class AuthController < ApplicationController

  def google_auth
    validator = GoogleIDToken::Validator.new
    begin
        token = request.headers["Authorization"].split(' ').last 
        if token.nil?
            render json: { error: "No token provided" }, status: :unauthorized
        else
            payload = validator.check(token, ENV['GOOGLE_OAUTH_CLIENT_ID'])
            user = User.create_from_google(email: payload["email"], full_name: payload["name"]);
            token = encode_token(user.id)
            if user.present?
                user.token = token
                user.save
                render json: { user: user }, status: :ok
            else
                render json: {error: "You should add a token"}, status: :unauthorized
            end
        end
    rescue Exception => e
        render json: {error: e.message}, status: :forbidden
    end
  end
end