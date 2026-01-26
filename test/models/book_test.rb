require "test_helper"

class BookTest < ActiveSupport::TestCase
  setup do
    @category = categories(:one)
    @step = steps(:one)
  end

  test "valid with title" do
    book = Book.new(
      enabled: true,
      name: "Rails Guide",
      isbn: "978-4109999999",
      category: @category,
      step: @step
    )
    assert book.valid?
  end

  test "invalid with title" do
    book = Book.new(
      enabled: true,
      name: nil,
      isbn: "978-4109999999",
      category: @category,
      step: @step
    )
    assert book.invalid?
  end
end
