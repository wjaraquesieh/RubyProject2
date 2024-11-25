class CategoriesController < ApplicationController
  def index
    @categories = Category.all
                  .page(params[:page]).per(15)
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path, notice: "Category updated successfully."
    else
      redirect_to categories_path, alert: "Error updating category."
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
