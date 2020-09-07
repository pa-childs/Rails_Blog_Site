# frozen_string_literal: true

# Controller that defines user sessions
class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])

      session[:user_id] = user.id
      flash[:notice] = t('.login_successful_text')
      redirect_to user

    else

      flash.now[:alert] = t('.login_unsuccessful_text')
      render 'new'

    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = t('.logout_successful_text')
    redirect_to root_path
  end
end
