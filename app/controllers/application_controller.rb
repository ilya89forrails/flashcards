class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  private

  def default_url_options(_options = {})
    { locale: I18n.locale }
  end

  def set_locale
    if current_user
      I18n.locale = current_user.locale
    elsif params[:locale]
      I18n.locale = params[:locale]
    else
      I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
    end
  end
end
