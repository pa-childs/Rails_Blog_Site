class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show

    @articles = @user.articles.paginate(page: params[:page], per_page: 5)

  end

  def index

    @users = User.paginate(page: params[:page], per_page: 5)

  end

  def new

    @user = User.new

  end

  def edit


  end

  def update

    if @user.update(user_params)

      logger.info "Updated profile for: #{@user.username}: #{@user.email}"
      flash[:notice] ="Your account information was successfully updated."
      redirect_to @user

    else

      render 'edit'

    end

  end

  def create

    @user = User.new(user_params)

    if verify_recaptcha(model: @user) && @user.save

      session[:user_id] = @user.id
      logger.info "Created profile for: #{@user.username}: #{@user.email}"
      flash[:notice] = "#{@user.username} was successfully created."
      redirect_to articles_path

    else

      render 'new'

    end

  end

  def destroy

    @user.destroy
    session[:user_id] = nil if @user == current_user
    logger.info "Removed profile for: #{@user.username}: #{@user.email}"
    flash[:notice] = "The Account and all associated Articles have been deleted."
    redirect_to articles_path

  end

  private

  def set_user

    @user = User.find(params[:id])

  end

  def user_params

    params.require(:user).permit(:username, :email, :password)

  end

  def require_same_user

    if current_user != @user && !current_user.admin?

      flash[:alert] = "You can only edit or delete your own profile."
      redirect_to @user

    end

  end

end
