class User < ApplicationRecord
  belongs_to :profile
  has_many :orders

  validates :name, presence: true
  validates :user_name, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :password, presence: true
  validates :profile_id, presence: true

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :user_name, uniqueness: true
  validates :email, uniqueness: true
  validates :phone, numericality: { only_integer: true, message: "must be a valid phone number" }
end
