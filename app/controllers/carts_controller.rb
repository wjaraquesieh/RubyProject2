class CartsController < ApplicationController
  def index
    product_ids = session[:cart] || []
    @cart_items = Product.where(id: product_ids)
    @subtotal = @cart_items.sum { |item| item[:price] * 1 }

    currency = "CAD"
    tax_rate = TaxRate.find_by(currency_code: currency)&.tax_percentage || 0

    @tax = (@subtotal * tax_rate / 100).round(2)
    @total = (@subtotal + @tax).round(2)
  end

  def add
    session[:cart] ||= []
    session[:cart] << params[:product_id]

    respond_to do |format|
      format.html { redirect_to catalogs_path, notice: "Product added to cart!" }
      format.turbo_stream { render turbo_stream: turbo_stream.replace("cart-icon", partial: "shared/cart_icon") }
    end
  end

  def remove
    item = Cart.find_by(product_id: params[:product_id], user_id: current_user.id)
    item&.destroy
    redirect_to carts_path, notice: "Product removed from cart."
  end
end
