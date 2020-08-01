class ArticlesController < ApplicationController

  def show

    @article = Article.find(params[:id])

  end

  def index

    @articles = Article.all

  end

  def new



  end

  def create

    # Just shows the listed parameters on the screen
    # render plain: params[:article]

    # Whitelist the parameters that you wish to allow
    @article = Article.new(params.require(:article).permit(:title, :description))
    @article.save
    # render plain: @article.inspect

    # redirect_to article_path(@article)
    redirect_to @article

  end

end
