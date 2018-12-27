class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :user_id, only: %i[show edit update]

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(params[:user][:email], params[:user][:password])
      flash[:notice] = 'Welcome!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to(@user, notice: 'User was successfully updated.')
    else
      render action: 'edit'
    end
  end

  private

  def user_id
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
