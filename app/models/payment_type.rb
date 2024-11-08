class PaymentType < ApplicationRecord
  has_many :order_payments
end
