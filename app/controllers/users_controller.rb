# Controller that defines user CRUD
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :require_user, only: %i[edit update]
  before_action :require_same_user, only: %i[edit update destroy]

  def show
    @articles = @user.articles.order('articles.created_at DESC').paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def edit; end

  def update
    if @user.update(user_params)

      logger.info "Updated profile for: #{@user.username}: #{@user.email}"
      flash[:notice] = t('.account_updated_successfully_text')
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
      flash[:notice] = "#{@user.username} #{t('.account_create_successfully_text')}"
      redirect_to articles_path

    else

      render 'new'

    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    logger.info "Removed profile for: #{@user.username}: #{@user.email}"
    flash[:notice] = t('.account_deleted_successfully_text')
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
    return unless current_user != @user && !current_user.admin?

      flash[:alert] = t('.warning_text')
      redirect_to @user

  end
end
