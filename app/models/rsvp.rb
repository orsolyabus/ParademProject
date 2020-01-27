class Rsvp < ApplicationRecord
  belongs_to :event
  belongs_to :contact
  has_one :user, through: :event
  
  enum response: { no: 0, yes: 1 }
  
  validate :contact_is_users
  
  validates :response, presence: true
  validates(
    :contact_id,
    uniqueness: {
      scope: :event_id,
      message: "already responded"
    }
  )
  
  def contact_is_users
    unless user.contacts.ids.include?(contact_id)
      errors.add(:contact, "must belong to this user")
    end
  end
  
end
