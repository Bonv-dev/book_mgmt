require "test_helper"

class FloorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @floor = floors(:one)
    @user = users(:admin)
    sign_in @user
  end

  test "should get index" do
    get floors_url
    assert_response :success
  end

  test "should get new" do
    get new_floor_url
    assert_response :success
  end

  test "should create floor" do
    new_name = @floor.name+"_NEW"
    assert_difference("Floor.count") do
      post floors_url, params: { floor: { enabled: @floor.enabled, name: new_name } }
    end

    assert_redirected_to floor_url(Floor.last)
  end

  test "should show floor" do
    get floor_url(@floor)
    assert_response :success
  end

  test "should get edit" do
    get edit_floor_url(@floor)
    assert_response :success
  end

  test "should update floor" do
    patch floor_url(@floor), params: { floor: { enabled: @floor.enabled, name: @floor.name } }
    assert_redirected_to floor_url(@floor)
  end

  test "should not destroy floor" do
    assert_no_difference "Floor.count" do
      delete floor_url(@floor)
    end

    assert_response :unprocessable_entity
  end

  test "should destroy floor" do
    floor_deletable = floors(:deletable)
    assert_difference("Floor.count", -1) do
      delete floor_url(floor_deletable)
    end

    assert_redirected_to floors_url
  end
end
