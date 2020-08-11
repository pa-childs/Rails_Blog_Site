class CategoriesController < ApplicationController

  def show

    @category = Category.find(params[:id])

  end

  def index



  end

  def new

    @category = Category.new

  end

  def create

    @category = Category.new(category_params)
    if @category.save

      flash[:notice] = "Category was successfully saved."

      redirect_to @category

    else

      # If something goes wrong, reload New page with validation messages
      render 'new'

    end

  end

  private

  def category_params

    params.require(:category).permit(:name)

  end

end
