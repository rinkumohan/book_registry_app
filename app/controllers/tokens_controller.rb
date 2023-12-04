class TokensController < ApplicationController

  skip_before_action :authenticate_user, only: [:create]

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.valid_password?(params[:password])
        token = JwtService.encode({ email: @user.email })
        render json: { auth_token: token }
    else
      render json: { error: "Incorrect Email or password" }, status:
      :unauthorized
    end
  end
end
