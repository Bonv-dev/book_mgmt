class LogPolicy < ApplicationPolicy
  def show?
    user&.can_manage?
  end

  def create?
    user&.can_manage?
  end

  def new?
    create?
  end

  def update?
    user&.is_admin?
  end

  def edit?
    update?
  end

  def destroy?
    user&.is_admin?
  end

  # 一覧のスコープ
  class Scope < Scope
    def resolve
      if user.is_ippan?
        raise Pundit::NotAuthorizedError, "一覧は見れません"
      end
      scope.all
    end
  end
end
