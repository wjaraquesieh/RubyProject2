class ShippingAddress < ApplicationRecord
  validates :first_name, :last_name, :address, :city, :province_id, :postal_code, :country, presence: true
end
