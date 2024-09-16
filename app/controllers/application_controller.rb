class ApplicationController < ActionController::API
  before_action :authenticate_user, except: [:create]  # Hapus login dari pengecualian

  def authenticate_user
    token = request.headers['Authorization']
    @current_user = Session.find_by(token: token)&.user
    render json: { error: "Tidak diizinkan" }, status: :unauthorized unless @current_user
  end
end
