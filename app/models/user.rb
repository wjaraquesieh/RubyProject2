class User < ApplicationRecord
  belongs_to :profile
  has_many :orders
end
