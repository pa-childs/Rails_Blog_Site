class ArticlesController < ApplicationController

  def show

    # Show the article for the supplied ID
    @article = Article.find(params[:id])

  end

  def index

    # List all the existing Articles
    @articles = Article.all

  end

  def new

    # Setup a new Article
    # Need an instance created to avoid error when page loads (validaton check)
    @article = Article.new

  end

  def edit

    # Setup to edit the article for the supplied ID
    # Need an instance created to avoid error when page loads (validaton check)
    @article = Article.find(params[:id])

  end

  def create

    # Create the new article with the supplied inputs, then load the new Article page

    # Just shows the listed parameters on the screen
    # render plain: params[:article]

    # Whitelist the parameters that you wish to allow
    @article = Article.new(params.require(:article).permit(:title, :description))
    if @article.save

      flash[:notice] = "Article was successfully saved."
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
    @article = Article.find(params[:id])
    if @article.update(params.require(:article).permit(:title, :description))
      flash[:notice] = "Article was successfully updated."
      redirect_to @article
    else

      # If something goes wrong, reload Edit page with validation messages
      render 'edit'

    end

  end

  def destroy

    # Destroy the article for the supplied ID, then load the Articles page
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path

  end

end
