class Guest < ApplicationRecord
  has_many :phone_numbers, dependent: :destroy
  has_many :reservations, dependent: :destroy

  accepts_nested_attributes_for :phone_numbers, allow_destroy: true

  validates :email, :first_name, :last_name, presence: true
  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP,
                      message: 'is not of valid format.'
            }

end
