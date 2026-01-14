class Floor < ApplicationRecord
  has_many :cabinets, dependent: :restrict_with_error

  validates :enabled, inclusion: [true, false]
  validates :name, presence: true, uniqueness: true

  include CommonScopes
end
