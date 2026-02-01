class UserPolicy < ApplicationPolicy
  def show?
    return true if user&.can_manage?
    record.id == user.id
  end

  def create?
    user&.can_manage?
  end

  def new?
    create?
  end

  def update?
    return true if user&.can_manage?
    record.id == user.id
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
    # アドミン以外は、is_admin, is_librarian フラグを変更できない (パラメータに指定させない)
    if (params.key?(:is_admin) || params.key?(:is_librarian)) && !user.is_admin?
      raise Pundit::NotAuthorizedError, "管理者以外は権限を変更できません"
    end

    # 一般は、enabled フラグを変更できない (パラメータに指定させない)
    if params.key?(:enabled) && user.is_ippan?
      raise Pundit::NotAuthorizedError, "有効/無効を変更できません"
    end

    # 自分自身の enabled, is_admin は変更できない
    if (params.key?(:enabled) && ActiveModel::Type::Boolean.new.cast(params[:enabled]) != record.enabled ||
        params.key?(:is_admin) && ActiveModel::Type::Boolean.new.cast(params[:is_admin]) != record.is_admin) &&
       record.id == user.id
      return "自分自身の Enabled, Is admin は変更できません。"
    end

    # 司書は、アドミンの enabled を変更できない
    if params.key?(:enabled) && user.is_librarian? && record.is_admin? &&
       ActiveModel::Type::Boolean.new.cast(params[:enabled]) != record.enabled
      return "司書はアドミンの Enabled は変更できません。"
    end

    nil
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
