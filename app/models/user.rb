class User < ApplicationRecord
  belongs_to :profile
  has_many :orders

  validates :name, presence: true
  validates :user_name, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :password, presence: true
  validates :profile_id, presence: true
end
