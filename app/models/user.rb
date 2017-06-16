class User < ApplicationRecord
  has_secure_password

  attr_accessor :full_name, :email, :password, :password_confirmation

  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
