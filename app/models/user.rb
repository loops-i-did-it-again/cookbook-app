class User < ApplicationRecord

  has_many :recipes
  has_many :messages

  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :name, length: { maximum: 30 }
  validates :password, length: { in: 6..20 }
end
