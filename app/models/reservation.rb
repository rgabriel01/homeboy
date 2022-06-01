class Reservation < ApplicationRecord
  belongs_to :guest

  validates :guest_id, :code, presence: true
  validates :code, uniqueness: { scope: :code }
end
