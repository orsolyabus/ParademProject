class User < ApplicationRecord
  has_secure_password
  has_many :contacts
  has_many :events
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  
  validates :name, presence: :true
  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX
  
end
