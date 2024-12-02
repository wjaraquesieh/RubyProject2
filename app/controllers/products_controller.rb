class ProductsController < ApplicationController
  def index
    @products = Product.all
                  .page(params[:page]).per(15)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @categories = Category.all
    @product_types = ProductType.all
  end

  def create
    @product = Product.new(product_params)

    # Validation to delete the image if already exist to save the new one
    if @product.image.present?
      old_image_path = Rails.root.join("app", "assets", "images", @product.image)
      File.delete(old_image_path) if File.exist?(old_image_path)
    end

    if params[:product][:image].present?
      image_file = params[:product][:image]
      file_name = "#{SecureRandom.hex(8)}_#{image_file.original_filename}"
      file_path = Rails.root.join("app", "assets", "images", file_name)

      # Save the file
      File.open(file_path, "wb") do |file|
        file.write(image_file.read)
      end

      # Save the name on the table products on db
      @product.image = file_name
    end

    if @product.save
      redirect_to products_path, notice: "Product created successfully."
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all
    @product_types = ProductType.all
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path, notice: "Product successfully deleted."
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :currency, :image, :description, :stock, :product_type_id, :category_id)
  end
end
