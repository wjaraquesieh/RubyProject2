class Status < ApplicationRecord
  has_many :order_statuses
  has_many :orders, through: :order_statuses
end
