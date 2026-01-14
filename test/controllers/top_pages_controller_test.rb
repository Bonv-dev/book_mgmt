require "test_helper"

class TopPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
    sign_in @user
  end

  test "should get index" do
    get top_pages_index_url
    assert_response :success
  end
end
