class ApplicationController < ActionController::API
  before_action :authenticate_user, except: [:create]  

  def authenticate_user
    token = request.headers['Authorization']
    @current_user = Session.find_by(token: token)&.user
    render json: { error: "Not allowed" }, status: :unauthorized unless @current_user
  end
end
