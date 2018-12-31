class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  skip_before_action :require_login, only: %i[index new create]

  private

  def not_authenticated
    redirect_to root_path, alert: 'Please login first.'
  end
end
