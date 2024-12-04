class ProductTypeController < ApplicationController
  before_action :require_login

  def index
    @productTypes = ProductType.all
                  .page(params[:page]).per(15)
  end

  def create
    unless params(:product_type)
      params[:product_type] = { description: params[:description] }
    end
    @productType = ProductType.new(productType_params)

    if @productType.save
      redirect_to product_type_path, notice: "Product Type created successfully."
    else
      flash.now[:alert] = "There was an error creating the product type."
      render :index
    end
  end

  def update
    @productType = ProductType.find(params[:id])

    unless params[:product_type]
      params[:productType] = { description: params[:description] }
    end

    if @productType.update(productType_params)
      redirect_to product_type_path, notice: "Product Type updated successfully."
    else
      flash[:alert] = "Error updating Product Type."
      render :index
    end
  end

  def destroy
    @productType = ProductType.find(params[:id])
    if @productType.destroy
      redirect_to product_type_path, notice: "Product Type deleted successfully."
    else
      redirect_to product_type_path, alert: "Error deleting Product Type."
    end
  end

  private

  def productType_params
    params.require(:product_type).permit(:description)
  end
end
