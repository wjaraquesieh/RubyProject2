class CartsController < ApplicationController
  def index
  end

  def add
    Cart.create(product_id: params[:product_id], user_id: current_user.id)
    redirect_to root_path, notice: "Product added to cart!"
  end
end
