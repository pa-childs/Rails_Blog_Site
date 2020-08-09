module ApplicationHelper

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
