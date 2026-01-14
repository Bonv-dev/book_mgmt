# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # ゲスト（未ログイン）
    return unless user

    if user.is_admin?
      # 管理者は全権限あり
      can :manage, :all
    elsif user.is_librarian?
      # 司書

      # 基本的に禁止
      cannot :manage, :all
      
      # 全ユーザー、蔵書情報の操作は可能
      can :manage, User
      can :manage, Book

      # ログは閲覧のみ可能 (編集は不可)
      can [:index, :show], Log

      # 全モデルの destroy 禁止
      cannot :destroy, :all
    else
      # 一般ユーザー
      
      # 基本的に禁止
      cannot :manage, :all
      
      # 蔵書の一覧は可能
      can :index, Book
      
      # 自分自身は編集可能
      can [:show, :edit, :update], User, id: user.id
    end
  end
end
