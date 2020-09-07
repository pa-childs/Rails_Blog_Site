# frozen_string_literal: true

# Controller that defines categories CRUD
class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update]
  before_action :require_admin, except: %i[index show]

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def edit; end

  def update
    if @category.update(category_params)

      flash[:notice] = t('.category_updated_successfully_text')
      redirect_to @category

    else

      render 'edit'

    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save

      flash[:notice] = t('.category_created_successfully_text')

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

  def set_category
    @category = Category.find(params[:id])
  end

  def require_admin
    return if logged_in? && current_user.admin?

    flash[:alert] = t('.warning_text')
    redirect_to categories_path
  end
end
