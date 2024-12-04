class Product < ApplicationRecord
  belongs_to :product_type
  belongs_to :category
  has_many :order_products
  has_many :orders, through: :order_products
  has_many :carts

  validates :name, presence: true
  validates :price, presence: true
  validates :currency, presence: true
  validates :stock, presence: true
  validates :description, presence: true
  validates :image, presence: true
  validates :category_id, presence: true
  validates :product_type_id, presence: true
end
