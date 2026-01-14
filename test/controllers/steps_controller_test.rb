require "test_helper"

class StepsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @step = steps(:one)
    @user = users(:admin)
    sign_in @user
  end

  test "should get index" do
    get steps_url
    assert_response :success
  end

  test "should get new" do
    get new_step_url
    assert_response :success
  end

  test "should create step" do
    new_name = @step.name+"_NEW"
    assert_difference("Step.count") do
      post steps_url, params: { step: { cabinet_id: @step.cabinet_id, enabled: @step.enabled, name: new_name } }
    end

    assert_redirected_to step_url(Step.last)
  end

  test "should show step" do
    get step_url(@step)
    assert_response :success
  end

  test "should get edit" do
    get edit_step_url(@step)
    assert_response :success
  end

  test "should update step" do
    patch step_url(@step), params: { step: { cabinet_id: @step.cabinet_id, enabled: @step.enabled, name: @step.name } }
    assert_redirected_to step_url(@step)
  end

  test "should not destroy step" do
    assert_no_difference "Step.count" do
      delete step_url(@step)
    end

    assert_response :unprocessable_entity
  end

  test "should destroy step" do
    step_deletable = steps(:deletable)
    assert_difference("Step.count", -1) do
      delete step_url(step_deletable)
    end

    assert_redirected_to steps_url
  end
end
