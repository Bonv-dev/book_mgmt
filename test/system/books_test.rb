require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @user = users(:admin)
    sign_in_for_systemtest(@user)
  end

  # -n test_should_get_index
  test "should get index" do

    # Books 一覧へ
    visit books_path

    # 画面確認
    assert_selector "h1", text: "Books"
  end
end
