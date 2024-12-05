class OrdersController < ApplicationController
  def index
  end

  def show
  end

  def create
    order = Order.new(order_params)
    order.user = current_user if logged_in?
    order.email = session[:guest_email] unless logged_in?
    if order.save
      redirect_to order_path(order), notice: "Your order has been placed!"
    else
      render :new, alert: "There was an issue with your order. Please try again."
    end
  end

  private

  def order_params
    params.require(:order).permit(:first_name, :last_name, :address, :apartment, :city, :province, :postal_code, :country, :phone, :delivery_method, :payment_type, :card_name, :card_number, :card_expiry, :card_cvc)
  end
end
