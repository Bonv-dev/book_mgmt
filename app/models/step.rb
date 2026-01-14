class Step < ApplicationRecord
  belongs_to :cabinet

  validates :enabled, inclusion: [true, false]
  validates :name, presence: true, uniqueness: { scope: :cabinet_id }

  include CommonScopes
end
