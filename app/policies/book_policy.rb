class BookPolicy < ApplicationPolicy
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
    user&.can_manage?
  end

  def edit?
    update?
  end

  def destroy?
    user&.is_admin?
  end

  # 変更内容がルールに適合しているか？
  # ・UI 的に操作できないハズのデータが来た場合は例外
  # ・操作はできるが規約違反の場合はメッセージを
  # ・規約通りなら nil
  def update_violation_message(params)
    # アドミン以外は、enabled を変更できない (パラメータに指定させない)
    if params.key?(:enabled) && !user.is_admin?
      raise Pundit::NotAuthorizedError, "有効/無効を変更できません"
    end
  end

  # 一覧のスコープ
  class Scope < Scope
    def resolve
      return scope.all
    end
  end
end
