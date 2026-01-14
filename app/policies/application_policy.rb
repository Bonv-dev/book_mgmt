# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  # === デフォルトはすべて拒否 ===
  def index?   = false
  def show?    = false
  def create?  = false
  def new?     = false
  def update?  = false
  def edit?    = false
  def destroy? = false

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise Pundit::NotAuthorizedError   # デフォルト拒否
    end

    private

    attr_reader :user, :scope
  end
end
