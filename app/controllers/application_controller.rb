class ApplicationController < ActionController::Base

  # function makes this available to controllers
  # helper_method makes this available for views
  helper_method :current_user, :logged_in?
  def current_user

    if session[:user_id]

      # Get current user info from database unless it was already accessed
      @current_user ||= User.find(session[:user_id])

    end

  end

  def logged_in?

    # logged in if current_user is true
    !!current_user

  end

end
