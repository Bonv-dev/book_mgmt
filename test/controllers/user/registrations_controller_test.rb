require "test_helper"

class UserRegistrationTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
    sign_in @user
  end

  test "user can not sign up" do
    assert_no_difference "User.count" do
      post user_registration_path, params: {
        user: {
          name: "", # invalid value
          email: "sign_up_test@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end
  end

  test "user can sign up" do
    assert_difference("User.count", 1) do
      post user_registration_path, params: {
        user: {
          name: "sign_up_test",
          email: "sign_up_test@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end

    assert_response :redirect
    follow_redirect!
    assert_response :success
  end
end
