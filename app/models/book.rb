class Book < ApplicationRecord
  belongs_to :category
  belongs_to :step

  validates :enabled, inclusion: [true, false]
  validates :name, presence: true
  validates :isbn, presence: true, uniqueness: true, format: { with: /\A(?:\d[\d-]{8,}[\dXx]|\d[\d-]{11,}\d)\z/ }
end
