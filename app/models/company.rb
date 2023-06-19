class Company < ApplicationRecord
  has_many :properties
  validates :company_name, presence: true
  validates :description, presence: true
end
