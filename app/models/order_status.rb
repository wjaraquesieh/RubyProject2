class OrderStatus < ApplicationRecord
  belongs_to :order
  belongs_to :status

  validates :active, uniqueness: { scope: :order_id, message: "Only one active status per order" }, if: -> { active }
end
