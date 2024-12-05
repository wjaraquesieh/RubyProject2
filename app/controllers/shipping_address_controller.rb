class ShippingAddressController < ApplicationController
  before_action :authenticate_user!

  def new
    @shipping_address = current_user.shipping_addresses.build
  end

  def create
    @shipping_address = current_user.shipping_addresses.build(shipping_address_params)
    if @shipping_address.save
      redirect_to user_path(current_user), notice: "Dirección agregada exitosamente."
    else
      render :new, alert: "Hubo un problema al agregar la dirección."
    end
  end

  def edit
    @shipping_address = current_user.shipping_addresses.find(params[:id])
  end

  def update
    @shipping_address = current_user.shipping_addresses.find(params[:id])
    if @shipping_address.update(shipping_address_params)
      redirect_to user_path(current_user), notice: "Dirección actualizada exitosamente."
    else
      render :edit, alert: "Hubo un problema al actualizar la dirección."
    end
  end

  private

  def shipping_address_params
    params.require(:shipping_address).permit(:first_name, :last_name, :address, :apartment, :city, :province_id, :postal_code, :country, :phone)
  end
end
