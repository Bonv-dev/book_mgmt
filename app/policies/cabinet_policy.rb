class CabinetPolicy < ApplicationPolicy
  def show?
    user&.is_admin?
  end

  def create?
    user&.is_admin?
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
      unless user.is_admin?
        raise Pundit::NotAuthorizedError, "一覧は見れません"
      end
      scope.all
    end
  end
end
