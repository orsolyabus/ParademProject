class Contact < ApplicationRecord
  validates :full_name, presence: true
  belongs_to :user
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email_primary, :email_secondary, format: VALID_EMAIL_REGEX
  
  def self.search(phrase)
    where("full_name ILIKE ?", "%#{phrase}%")
  end
end
