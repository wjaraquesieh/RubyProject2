class CartsController < ApplicationController
  def index
    if logged_in?
      @cart_items = Cart.where(user_id: current_user.id).includes(:product)
      @subtotal = @cart_items.sum { |item| item.product.price * 1 }

      currency = "CAD"
      tax_rate = TaxRate.find_by(currency_code: currency)&.tax_percentage || 0
      @tax = (@subtotal * tax_rate / 100).round(2)
      @total = (@subtotal + @tax).round(2)
    else
      product_ids = session[:cart] || []
      @cart_items = Product.where(id: product_ids)
      @subtotal = @cart_items.sum { |item| item[:price] * 1 }

      currency = "CAD"
      tax_rate = TaxRate.find_by(currency_code: currency)&.tax_percentage || 0

      @tax = (@subtotal * tax_rate / 100).round(2)
      @total = (@subtotal + @tax).round(2)
    end
  end

  def add
    if logged_in?
      #   cart_item = Cart.find_by(product_id: params[:product_id], user_id: current_user.id)

      # if cart_item
      #   cart_item.update(quantity: cart_item.quantity + 1)
      # else
      Cart.create(product_id: params[:product_id], user_id: current_user.id)
    # end
    else
      session[:cart] ||= []
      session[:cart] << params[:product_id]
    end

    respond_to do |format|
      format.html { redirect_to catalogs_path, notice: "Product added to cart!" }
      format.turbo_stream { render turbo_stream: turbo_stream.replace("cart-icon", partial: "shared/cart_icon") }
    end
  end

  def destroy
    if logged_in?
      @item = Cart.find_by(product_id: params[:product_id], user_id: current_user.id)

      if @item.destroy
        puts "Destroy"
          redirect_to cart_path, notice: "Product removed from cart."
      else
          redirect_to cart_path, alert: "Product not found in cart."
      end
    else
      session[:cart] ||= []
      session[:cart].delete(params[:product_id])

      respond_to do |format|
        format.html { redirect_to cart_path, notice: "Product removed from cart!" }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("cart-icon", partial: "shared/cart_icon") }
      end
    end
  end
end
