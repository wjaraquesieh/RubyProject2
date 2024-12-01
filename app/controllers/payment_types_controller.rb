class PaymentTypesController < ApplicationController
  def index
    @paymentTypes = PaymentType.all
                    .page(params[:page]).per(15)
  end

  def create
    unless params[:paymentTypes]
      params[:paymentTypes] = { name: params[:name] }
    end
    @paymentTypes = PaymentType.new(paymentTypes_params)

    if @paymentTypes.save
      redirect_to payment_types_path, notice: "Payment Types created successfully."
    else
      flash.now[:alert] = "There was an error creating the Payment Types."
      render :index
    end
  end

  def update
    @paymentTypes = PaymentType.find(params[:id])

    unless params[:paymentTypes]
      params[:paymentTypes] = { name: params[:name] }
    end

    if @paymentTypes.update(paymentTypes_params)
      redirect_to payment_types_path, notice: "Payment Types updated successfully."
    else
      flash[:alert] = "Error updating Payment Types."
      render :index
    end
  end

  def destroy
    @paymentTypes = PaymentType.find(params[:id])
    if @paymentTypes.destroy
      redirect_to payment_types_path, notice: "Payment Types deleted successfully."
    else
      redirect_to payment_types_path, alert: "Error deleting Payment Types."
    end
  end

  private

  def paymentTypes_params
    params.require(:paymentTypes).permit(:name)
  end
end
