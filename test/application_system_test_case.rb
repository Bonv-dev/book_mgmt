require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]
  # driven_by :selenium, using: :chrome, screen_size: [ 1400, 1400 ]

  # Capybara でのログイン
  def sign_in_for_systemtest(user, target_path = root_path)
    visit new_user_session_path
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: TestConstants::DEFAULT_PASSWORD
    click_button "Log in"
    assert_current_path target_path # ログインが終わるのを待つ
  end
end
