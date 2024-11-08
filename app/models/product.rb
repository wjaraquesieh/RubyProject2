class Product < ApplicationRecord
  belongs_to :product_type
  belongs_to :category
  has_many :order_products
  has_many :orders, through: :order_products
end
