class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  allow_browser versions: :modern
  protect_from_forgery with: :null_session


  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username, :username, :email, :password, :password_confirmation, :user_prof_pic ])
    devise_parameter_sanitizer.permit(:sign_in, keys: [ :email, :password, :password_confirmation ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username, :username, :email, :password_confirmation, :current_password, :user_prof_pic ])
  end
end
