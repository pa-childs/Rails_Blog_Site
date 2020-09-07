# frozen_string_literal: true

# Base Rails controller
class ApplicationController < ActionController::Base
  # function makes this available to controllers
  # helper_method makes this available for views
  helper_method :current_user, :logged_in?
  def current_user
    return unless session[:user_id]

    # Get current user info from database unless it was already accessed
    @current_user ||= User.find(session[:user_id])
  end

  def logged_in?
    # logged in if current_user is true
    !!current_user
  end

  def require_user
    return if logged_in?

    flash[:alert] = t('.warning_text')
    redirect_to login_path
  end

  around_action :switch_locale

  def switch_locale(&action)
    # Set the locale to be used in URLs
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    # Include locale in the query string
    # This is overridden in routes.rb to organize the URL
    { locale: I18n.locale }
  end
end
