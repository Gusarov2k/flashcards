class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  before_action :require_login

  private

  def not_authenticated
    redirect_to log_in_path, notice: 'Please login first.'
  end
end
