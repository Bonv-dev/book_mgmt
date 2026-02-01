# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!
  before_action :authorize_admin, only: [ :new, :create, :destroy ]

  private

  def authorize_admin
    redirect_to root_path, alert: "権限がありません" unless current_user&.is_admin?
  end

  # Devise がログイン済みユーザーを弾く動作を無効化
  def require_no_authentication
    # 管理者なら無視して new/create を許可
    return if current_user&.is_admin?

    super
  end
end
