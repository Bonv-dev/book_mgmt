class Cabinet < ApplicationRecord
  belongs_to :floor

  validates :enabled, inclusion: [true, false]
  validates :name, presence: true, uniqueness: { scope: :floor_id }

  include CommonScopes
end
