require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @user = users(:admin)
    sign_in_for_systemtest(@user)
    @book = books(:one)
  end

  # -n test_should_get_index
  test "should get index" do

    # Books 一覧へ
    visit books_path

    # 画面確認
    assert_selector "h1", text: "Books"
  end

  # -n test_select_places
  test "select places" do
    visit edit_book_path(@book)

    # デフォルトでは何らかの値が選択されていることを確認
    assert_not find("#floor_id").find("option", text: "選択してください").selected?
    assert_not find("#cabinet_id").find("option", text: "選択してください").selected?
    assert_not find("#book_step_id").find("option", text: "選択してください").selected?

    # Floor で「2F」を選択
    select "2F", from: "floor_id"

    # Cabinet, Step が変更されることを確認
    assert find("#cabinet_id").find("option", text: "選択してください").selected?
    assert find("#book_step_id").find("option", text: "選択してください").selected?
    check_cannot_update_book

    # Cabinet で「C101」を選択
    select "C101", from: "cabinet_id"
    assert find("#floor_id").find("option", text: "2F").selected?
    assert find("#cabinet_id").find("option", text: "C101").selected?
    assert find("#book_step_id").find("option", text: "選択してください").selected?
    check_cannot_update_book

    # Step で「step_two」を選択
    select "step_two", from: "book_step_id"
    assert find("#floor_id").find("option", text: "2F").selected?
    assert find("#cabinet_id").find("option", text: "C101").selected?
    assert find("#book_step_id").find("option", text: "step_two").selected?

    # Cabinet で「C102」を選択
    select "C102", from: "cabinet_id"
    assert find("#floor_id").find("option", text: "2F").selected?
    assert find("#cabinet_id").find("option", text: "C102").selected?
    assert find("#book_step_id").find("option", text: "選択してください").selected?
    check_cannot_update_book

    # Step で「step_two_2」を選択
    select "step_two_2", from: "book_step_id"

    # データが更新されることを確認する
    click_button "Update Book"
    assert_current_path book_path(@book)
    assert_text "[2F] [C102] step_two_2"
  end

  private

    # "Update Book" ボタンによる保存が拒否されることを確認
    def check_cannot_update_book
      alert_text = accept_alert do
        click_button "Update Book"
      end
      assert_equal "選択してください", alert_text
    end
end
