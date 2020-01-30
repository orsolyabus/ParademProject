class Introduction < ApplicationRecord
  belongs_to :contact
  belongs_to :introduced_by, class_name: "Contact"

  enum relationship: [:friend, :family, :manager, :employee, :other]
  
  validates :relationship, presence: true
  validates(
    :contact_id,
    uniqueness: {
      scope: :introduced_by_id,
      message: "was already introduced",
    },
  )

end
