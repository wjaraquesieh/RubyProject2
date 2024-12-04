class DeliveriesController < ApplicationController
  before_action :require_login

  def index
    @deliveries = Delivery.all
                  .page(params[:page]).per(15)
  end

  def create
    unless params[:delivery]
      params[:delivery] = { description: params[:description] }
    end
    @delivery = Delivery.new(delivery_params)

    if @delivery.save
      redirect_to deliveries_path, notice: "Delivery created successfully."
    else
      flash.now[:alert] = "There was an error creating the delivery."
      render :index
    end
  end

  def update
    @delivery = Delivery.find(params[:id])

    unless params[:delivery]
      params[:delivery] = { description: params[:description] }
    end

    if @delivery.update(delivery_params)
      redirect_to deliveries_path, notice: "Delivery updated successfully."
    else
      flash[:alert] = "Error updating delivery."
      render :index
    end
  end

  def destroy
    @delivery = Delivery.find(params[:id])
    if @delivery.destroy
      redirect_to deliveries_path, notice: "delivery deleted successfully."
    else
      redirect_to deliveries_path, alert: "Error deleting delivery."
    end
  end

  private

  def delivery_params
    params.require(:delivery).permit(:description)
  end
end
