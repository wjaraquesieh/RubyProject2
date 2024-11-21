class User < ApplicationRecord
  belongs_to :profile
  has_many :orders

  validates :profile_id, presence: true
end
