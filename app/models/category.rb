class Category < ApplicationRecord
  has_many :books, dependent: :restrict_with_error

  validates :enabled, inclusion: [ true, false ]
  validates :name, presence: true, uniqueness: true

  include CommonScopes
end
