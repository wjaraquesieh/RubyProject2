class CatalogController < ApplicationController
  def index
    @products = Product.all
                  .page(params[:page]).per(15)
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @query = params[:query]

    @products = Product.where("name LIKE ?", "%#{@query}%")
    @products = @products.page(params[:page]).per(15)

    render :index
  end
end
