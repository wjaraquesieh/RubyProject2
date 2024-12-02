class ProductsController < ApplicationController
  def index
    @products = Product.all
                  .page(params[:page]).per(15)
  end

  def show
  end

  def new
    @product = Product.new
    @categories = Category.all
    @product_types = ProductType.all
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path, notice: "Product created successfully."
    else
      flash.now[:alert] = "Error creating product."
      @categories = Category.all
      @product_types = ProductType.all
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :currency, :image, :description, :stock, :product_type_id, :category_id)
  end
end
