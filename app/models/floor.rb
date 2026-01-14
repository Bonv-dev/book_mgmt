class Floor < ApplicationRecord
  validates :enabled, inclusion: [true, false]
  validates :name, presence: true, uniqueness: true
end
