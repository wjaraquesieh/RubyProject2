class PaymentTypesController < ApplicationController
  def index
    @paymentTypes = PaymentType.all
                    .page(params[:page]).per(15)
  end

  def show
  end
end
