class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  before_action :authenticate_user

  def authenticate_user
    if request.headers['HTTP_AUTH_TOKEN'].present?
      email = JwtService.decode(request.headers['HTTP_AUTH_TOKEN'])[0]["email"]
      @current_user = User.find_by(email: email)
      render json: { error: 'Not Authorized' }, status: 401 unless @current_user
    end
  end

  def user_sign_in?
    !!current_user
  end
end
