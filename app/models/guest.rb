class Guest < ApplicationRecord
  has_many :phone_numbers, dependent: :destroy

  validates :email, :first_name, :last_name, presence: true
  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP,
                      message: 'Email is not of valid format.'
            }

end
