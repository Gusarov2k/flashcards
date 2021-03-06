class OauthsController < ApplicationController
  skip_before_action :require_login

  # Sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]

    begin
      if @user == login_from(provider)
        redirect_to root_path, notice: "Logged in from #{provider.titleize}!"
      else
        begin
          @user = create_from(provider)
          @user.activate!
          reset_session # protect from session fixation attack
          auto_login(@user)
          redirect_to root_path, notice: "Logged in from #{provider.titleize}!"
        rescue StandardError
          redirect_to root_path, alert: "Failed to login from #{provider.titleize}!"
        end
      end
    rescue ::OAuth2::Error => e
      Rails.logger.error e
      Rails.logger.error e.code
      Rails.logger.error e.description
      Rails.logger.error e.message
      Rails.logger.error e.backtrace
    end
  end
end
