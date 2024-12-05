class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :product_id, :order_id, :quantity, :product_price, presence: true
end
