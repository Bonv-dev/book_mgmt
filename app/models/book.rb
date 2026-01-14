class Book < ApplicationRecord
  belongs_to :category
  belongs_to :step
  has_many :logs, dependent: :restrict_with_error

  validates :enabled, inclusion: [true, false]
  validates :name, presence: true
  validates :isbn, presence: true, uniqueness: true, format: { with: /\A(?:\d[\d-]{8,}[\dXx]|\d[\d-]{11,}\d)\z/ }

  include CommonScopes
end
