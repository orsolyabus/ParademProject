class Contact < ApplicationRecord
  belongs_to :user
  has_many :rsvps, dependent: :destroy
  has_one :introduction, dependent: :destroy
  has_one :introduced_by, through: :introduction
  
  accepts_nested_attributes_for :introduction, allow_destroy: true
  
  validates :full_name, presence: true
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
