class Step < ApplicationRecord
  belongs_to :cabinet

  validates :enabled, inclusion: [true, false]
  validates :name, presence: true
end
