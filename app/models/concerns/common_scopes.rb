module CommonScopes
  extend ActiveSupport::Concern

  included do
    scope :enabled_only, -> { where(enabled: true) }
  end

  class_methods do
    # データ表示用 (全データを持つ)
    def name_list
      self.pluck(:id, :name).to_h
    end

    # データ編集用 (有効なデータのみ)
    def name_options
      self.enabled_only.pluck(:name, :id).to_h
    end
  end
end
