class CategoriesController < ApplicationController
  before_action :require_login

  def index
    @categories = Category.all
                  .page(params[:page]).per(15)
  end

  def create
    unless params[:category]
      params[:category] = { description: params[:description] }
    end
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path, notice: "Category created successfully."
    else
      flash.now[:alert] = "There was an error creating the category."
      render :index
    end
  end

  def update
    @category = Category.find(params[:id])

    unless params[:category]
      params[:category] = { description: params[:description] }
    end

    if @category.update(category_params)
      redirect_to categories_path, notice: "Category updated successfully."
    else
      flash[:alert] = "Error updating category."
      render :index
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to categories_path, notice: "Category deleted successfully."
    else
      redirect_to categories_path, alert: "Error deleting category."
    end
  end

  private

  def category_params
    params.require(:category).permit(:description)
  end
end
