require "test_helper"

class CabinetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cabinet = cabinets(:one)
    @user = users(:admin)
    sign_in @user
  end

  test "should get index" do
    get cabinets_url
    assert_response :success
  end

  test "should get new" do
    get new_cabinet_url
    assert_response :success
  end

  test "should create cabinet" do
    new_name = @cabinet.name+"_NEW"
    assert_difference("Cabinet.count") do
      post cabinets_url, params: { cabinet: { enabled: @cabinet.enabled, floor_id: @cabinet.floor_id, name: new_name } }
    end

    assert_redirected_to cabinet_url(Cabinet.last)
  end

  test "should show cabinet" do
    get cabinet_url(@cabinet)
    assert_response :success
  end

  test "should get edit" do
    get edit_cabinet_url(@cabinet)
    assert_response :success
  end

  test "should update cabinet" do
    patch cabinet_url(@cabinet), params: { cabinet: { enabled: @cabinet.enabled, floor_id: @cabinet.floor_id, name: @cabinet.name } }
    assert_redirected_to cabinet_url(@cabinet)
  end

  test "should not destroy cabinet" do
    assert_no_difference "Cabinet.count" do
      delete cabinet_url(@cabinet)
    end

    assert_response :unprocessable_entity
  end

  test "should destroy cabinet" do
    cabinet_deletable = cabinets(:deletable)
    assert_difference("Cabinet.count", -1) do
      delete cabinet_url(cabinet_deletable)
    end

    assert_redirected_to cabinets_url
  end
end
