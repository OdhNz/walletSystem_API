class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      token = SecureRandom.hex
      Session.create!(user: user, token: token)
      render json: { token: token }, status: :created
    else
      render json: { error: " Wrong Email or password" }, status: :unauthorized
    end
  end
end
