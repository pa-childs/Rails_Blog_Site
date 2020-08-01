class ArticlesController < ApplicationController

  def show

    @article = Article.find(params[:id])

  end

  def index

    @articles = Article.all

  end

  def new

    # Need an instance created to avoid error when page loads (validaton check)
    @article = Article.new

  end

  def edit

    # Need an instance created to avoid error when page loads (validaton check)
    @article = Article.find(params[:id])

  end

  def create
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

      # Go back to new page if something goes wrong
      render 'new'

    end

  end

  def update
    
    @article = Article.find(params[:id])
    if @article.update(params.require(:article).permit(:title, :description))
      flash[:notice] = "Article was successfully updated."
      redirect_to @article
    else

      render 'edit'
    end

  end

end
