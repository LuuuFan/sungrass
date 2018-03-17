class Api::UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      session[:session_token] = @user.session_token
      render 'api/users/session'
    else
      render json: @user.errors.full_messages, status: 422
    end
  end

  def show
    @user = User.find_by(username: params[:id])
    if @user
      render :show
    else
      render :json: ['Cannot find this user']
    end
  end

  private
  def user_params
    params.require(:user).permit(
      :username,
      :password,
      :email,
      :avatar,
      :first_name,
      :last_name
    )
  end

end
