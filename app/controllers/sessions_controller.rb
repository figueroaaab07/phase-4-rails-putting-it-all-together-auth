class SessionsController < ApplicationController
  before_action :authorize, only: [:destroy]

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: user, status: :ok
    else
      render json: { errors: ["Invalid username or password"] }, status: :unauthorized
    end
  end

  def destroy
    # if session.include? :user_id
      session.delete :user_id
      # head :no_content
      render json: {}, status: :no_content
    # else
    #   render json: { errors: ["Invalid username or password"] }, status: :unauthorized
    # end
  end
end
