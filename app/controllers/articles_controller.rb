class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  # prevents users from bypassing security via URL manipulation
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show

    # Show the article for the supplied ID

  end

  def index

    # List all the existing Articles
    @articles = Article.order('articles.created_at DESC').paginate(page: params[:page], per_page: 5)

  end

  def new

    # Setup a new Article
    # Need an instance created to avoid error when page loads (validaton check)
    @article = Article.new

  end

  def edit

    # Setup to edit the article for the supplied ID

  end

  def create

    # Create the new article with the supplied inputs, then load the new Article page

    # Just shows the listed parameters on the screen
    # render plain: params[:article]

    # Whitelist the parameters that you wish to allow
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save

      flash[:notice] = t('.article_created_successfully_text')
      # render plain: @article.inspect

      redirect_to article_path(@article)
      # Shorthand version
      # redirect_to @article

    else

      # If something goes wrong, reload New page with validation messages
      render 'new'

    end

  end

  def update

    # Update the article for the supplied ID, the reload the Article page
    if @article.update(article_params)
      flash[:notice] = t('.article_updated_successfully_text')
      redirect_to article_path(@article)
    else

      # If something goes wrong, reload Edit page with validation messages
      render 'edit'

    end

  end

  def destroy

    # Destroy the article for the supplied ID, then load the Articles page
    @article.destroy
    flash[:notice] = t('.article_deleted_successfully_text')
    redirect_to articles_path

  end

  private

  def set_article

    @article = Article.find(params[:id])

  end

  def article_params

    params.require(:article).permit(:title, :description, category_ids: [])

  end

  def require_same_user

    if current_user != @article.user and !current_user.admin?

      flash[:alert] = t('.warning_text')
      redirect_to @article

    end

  end

end
