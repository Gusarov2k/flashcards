class ApplicationController < ActionController::Base
  before_action :set_locale
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :require_login

  private

  def default_url_options
    { locale: I18n.locale }
  end

  def not_authenticated
    redirect_to log_in_path, notice: 'Please login first.'
  end

  def set_locale
    I18n.locale = if params[:locale]
                    session[:locale] = params[:locale]
                  else
                    http_accept_language.compatible_language_from(I18n.available_locales)
                  end
  end
end
