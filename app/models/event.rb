class Event < ApplicationRecord
  belongs_to :user
  has_many :rsvps

  validates :name, presence: true
  # validate :date_in_the_future
  validates :attendees, numericality: { greater_than: 0 }

  # def date_in_the_future
  #   if date.to_s > Date.today
  #     errors.add(date, "must be in the future")
  #   end
  # end
end
