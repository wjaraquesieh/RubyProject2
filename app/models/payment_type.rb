class PaymentType < ApplicationRecord
  has_many :order_payments

  validates :name, presence: true
end
