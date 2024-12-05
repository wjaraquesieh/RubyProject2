class OrdersController < ApplicationController
  def index
  end

  def show
    @order = Order.includes(:user, :shipping_address, :delivery, :status, order_products: :product).find(params[:id])
  end

  def create
    ActiveRecord::Base.transaction do
      # 1. Crear ShippingAddress
      shipping_address = ShippingAddress.create!(
        first_name: params[:first_name],
        last_name: params[:last_name],
        address: params[:address],
        apartment: params[:apartment],
        city: params[:city],
        province_id: params[:province],
        postal_code: params[:postal_code],
        country: params[:country],
        phone: params[:phone]
      )

      # 2. Crear la Orden
      order = Order.create!(
        total: params[:total],
        taxes: params[:taxes],
        email: params[:email],
        user_id: current_user&.id,
        delivery_id: params[:delivery],
        shipping_address_id: shipping_address.id
      )

      # 3. Crear OrderStatus
      OrderStatus.create!(
        order_id: order.id,
        status_id: 1,
        active: true
      )

      # 4. Crear OrderPayment
      OrderPayment.create!(
        order_id: order.id,
        payment_type_id: params[:payment_type],
        card_name: params[:card_name],
        card_number: params[:card_number],
        expiration: params[:card_expiry],
        security_code: params[:card_cvc]
      )

      # 5. Crear registros en OrderProduct para cada producto del carrito
      if logged_in?
        @cart_items = Cart.where(user_id: current_user.id).includes(:product)
        puts @cart_items
        @cart_items.each do |item|
          OrderProduct.create!(
            product_id: item[:id],
            order_id: order.id,
            quantity: 1,
            product_price: item[:price]
          )
        end
      else
        product_ids = session[:cart] || []
        @cart_items = Product.where(id: product_ids)
        @cart_items.each do |item|
          OrderProduct.create!(
            product_id: item[:id],
            order_id: order.id,
            quantity: 1,
            product_price: item[:price]
          )
        end
      end

      # Vaciar carrito tras completar la compra
      session[:cart] = []
    end

    # Redirección a la página de inicio con un mensaje de éxito
    redirect_to root_path, notice: "Order successfully placed!"
  rescue ActiveRecord::RecordInvalid => e
    # En caso de error, renderizar de nuevo la vista de checkout con mensajes de error
    flash[:alert] = "There was an error creating your order: #{e.message}"
    redirect_to checkout_path
  end

  def admin_index
    # Filtrar por estado si se proporciona un parámetro
    if params[:status].present?
      @orders = Order.joins(:status)
                     .where("status.name ILIKE ?", "%#{params[:status]}%")
                     .includes(:user, :shipping_address, :delivery, :status)
    else
      @orders = Order.includes(:user, :shipping_address, :delivery, :status)
    end
  end

  def update_status
    order = Order.find(params[:id]) # Asegúrate de que params[:id] esté llegando
    puts "Order: #{order.inspect}"
    puts order.id

    if params[:status_id].present?
      order.set_active_status(order.id, params[:status_id])
      redirect_to order_admin_path, notice: "Estado actualizado correctamente."
    else
      redirect_to order_admin_path, alert: "No se seleccionó ningún estado."
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :first_name, :last_name, :address, :apartment, :city, :province,
      :postal_code, :country, :phone, :email, :delivery, :total, :taxes,
      :payment_type, :card_name, :card_number, :card_expiry, :card_cvc
    )
  end
end
