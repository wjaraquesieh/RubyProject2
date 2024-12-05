class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :delivery
  belongs_to :shipping_address

  has_many :order_status
  has_many :status, through: :order_status

  has_many :order_products
  has_many :product, through: :order_products

  has_one :active_order_status, -> { where(active: true) }, class_name: "OrderStatus"
  has_one :active_status, through: :active_order_status, source: :status

  validates :total, :taxes, :email, :delivery_id, :shipping_address_id, presence: true

  def set_active_status(order_id, new_status_id)
    OrderStatus.where(order_id: order_id).update_all(active: false)
    OrderStatus.create(order_id: order_id, status_id: new_status_id, active: true)
  end
end
