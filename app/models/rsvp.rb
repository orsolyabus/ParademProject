class Rsvp < ApplicationRecord
  belongs_to :event
  belongs_to :contact
  
  enum response: { no: 0, yes: 1 }
  
  validates :response, presence: true
  validates(
    :contact_id,
    uniqueness: {
      scope: :event_id,
      message: "already responded"
    }
  )
end
