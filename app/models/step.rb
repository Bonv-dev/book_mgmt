class Step < ApplicationRecord
  belongs_to :cabinet

  validates :enabled, inclusion: [true, false]
  validates :name, presence: true, uniqueness: { scope: :cabinet_id }

  include CommonScopes

  class << self
    def floor_cabinet_step_list
      Step.joins(cabinet: :floor)
        .pluck("steps.id, floors.name, cabinets.name, steps.name")
        .map { |id, fname, cname, sname| [id, "[#{fname}] [#{cname}] #{sname}"] }.to_h
    end
  end
end
