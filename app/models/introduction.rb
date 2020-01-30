class Introduction < ApplicationRecord
  belongs_to :contact, optional: true
  belongs_to :introduced_by, class_name: "Contact", optional: true

  enum relationship: [:friend, :family, :manager, :employee, :other]
  
  validates(
    :contact_id,
    uniqueness: {
      scope: :introduced_by_id,
      message: "was already introduced",
    },
  )

end
