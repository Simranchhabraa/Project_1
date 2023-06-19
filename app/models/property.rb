class Property < ApplicationRecord
  has_many :seats
  has_many :bookings
  has_many :available_slots
  has_one :address, dependent: :destroy
  belongs_to :company
  validates :name, presence: true
  # validates :google_location_link, presence: true 
end
