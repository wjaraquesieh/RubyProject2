class CatalogController < ApplicationController
  def index
    @products = Product.where(product_type_id: 1)
                  .page(params[:page]).per(15)
  end

  def accessory
    @products = Product.where(product_type_id: 2)
                  .page(params[:page]).per(15)
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @query = params[:query]
    puts params[:query]
    @products = Product.where("name LIKE ? ", "%#{@query}%")
    puts @product
    @products = @products.page(params[:page]).per(15)
  end
end
