class Contact < ApplicationRecord
  validates :full_name, presence: true
  belongs_to :user
  has_many :rsvps

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email_primary, :email_secondary, format: VALID_EMAIL_REGEX, allow_blank: true

  def self.search(phrase = "")
    where("full_name ILIKE ? 
      OR phone_primary ILIKE ? 
      OR phone_secondary ILIKE ?
      OR email_primary ILIKE ?
      OR email_secondary ILIKE ?
      OR organisation ILIKE ?
      OR notes ILIKE ?",
      "%#{phrase}%", "%#{phrase}%", "%#{phrase}%", "%#{phrase}%", 
      "%#{phrase}%", "%#{phrase}%", "%#{phrase}%")
      .order(full_name: :asc)
  end
end
