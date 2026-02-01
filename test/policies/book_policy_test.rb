require "test_helper"

class BookPolicyTest < ActiveSupport::TestCase
  def setup
    @admin      = users(:admin)
    @librarian  = users(:librarian)
    @ippan      = users(:one)

    @book = books(:one)
  end

  def test_scope
    scope = Pundit.policy_scope(@ippan, Book)
    assert_includes scope, @book
  end

  def test_show
    policy = BookPolicy.new(@ippan, @book)
    assert !policy.show?
  end

  def test_create
    policy = BookPolicy.new(@ippan, @book)
    assert !policy.create?
  end

  def test_update
    policy = BookPolicy.new(@admin, @book)
    assert policy.update?

    policy = BookPolicy.new(@librarian, @book)
    assert policy.update?

    policy = BookPolicy.new(@ippan, @book)
    assert !policy.update?
  end

  def test_destroy
    policy = BookPolicy.new(@librarian, @book)
    assert !policy.destroy?

    policy = BookPolicy.new(@ippan, @book)
    assert !policy.destroy?

    policy = BookPolicy.new(@admin, @book)
    assert policy.destroy?
  end
end
