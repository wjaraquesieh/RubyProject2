class Order < ApplicationRecord
  belongs_to :user
  belongs_to :delivery
  belongs_to :shipping_address
  has_many :order_products
  has_many :products, through: :order_products
  has_many :order_statuses
  has_many :statuses, through: :order_statuses
  has_many :order_payments
end
