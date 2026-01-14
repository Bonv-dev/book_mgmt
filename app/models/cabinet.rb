class Cabinet < ApplicationRecord
  belongs_to :floor
  has_many :steps, dependent: :restrict_with_error

  validates :enabled, inclusion: [true, false]
  validates :name, presence: true, uniqueness: { scope: :floor_id }

  include CommonScopes

  class << self
    def floor_cabinet_list
      Cabinet.joins(:floor)
        .pluck("cabinets.id, floors.name, cabinets.name")
        .map { |id, fname, cname| [id, "[#{fname}] #{cname}"] }.to_h
    end
  end
end
