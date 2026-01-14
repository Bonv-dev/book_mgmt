class TopPagePolicy < ApplicationPolicy
  # トップページは全員アクセス可
  def index?
    true    # 全員アクセス可
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope # 何もフィルタしない（全員OK）
    end
  end
end
