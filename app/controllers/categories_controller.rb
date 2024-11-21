class CategoriesController < ApplicationController
  def index
    @categories = Category.all
                  .page(params[:page]).per(15)
  end

  def show
  end
end
