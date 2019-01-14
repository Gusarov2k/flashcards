class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  def new; end

  def create
    if login(params[:email], params[:password], params[:remember_me])
      flash[:notice] = 'Welcome back!'
      redirect_back_or_to root_path
    else
      flash.now[:notice] = 'E-mail and/or password is incorrect.'
      render 'new'
    end
  end

  def destroy
    logout
    flash[:notice] = 'See you!'
    redirect_to log_in_path
  end
end
