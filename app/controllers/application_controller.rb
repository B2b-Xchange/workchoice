class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # 13/06/2016 add localization
  before_filter :set_locale

  # 13/06/2016 rails i18n docs
  def default_url_options
    { locale: I18n.locale }
  end
  
  private

  # confirm a logged in user, moved from users_controller
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t(:controller_application_logged_in_flash_danger)
      redirect_to login_url
    end
  end

  def set_locale
    I18n.locale = supported_locale_or_inferred
  end

  def supported_locale_or_inferred
    if params[:locale] == "en" || params[:locale] == "de"
      params[:locale]
    else
      http_accept_language.compatible_language_from(I18n.available_locales)
      # I18n.default_locale
    end
  end
  
end
