require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:one)
    @user = users(:admin)
    sign_in @user
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should get new" do
    get new_category_url
    assert_response :success
  end

  test "should create category" do
    new_name = @category.name+"_NEW"
    assert_difference("Category.count") do
      post categories_url, params: { category: { enabled: @category.enabled, name: new_name } }
    end

    assert_redirected_to category_url(Category.last)
  end

  test "should show category" do
    get category_url(@category)
    assert_response :success
  end

  test "should get edit" do
    get edit_category_url(@category)
    assert_response :success
  end

  test "should update category" do
    patch category_url(@category), params: { category: { enabled: @category.enabled, name: @category.name } }
    assert_redirected_to category_url(@category)
  end

  test "should not destroy category" do
    assert_no_difference "Category.count" do
      delete category_url(@category)
    end

    assert_response :unprocessable_entity
  end

  test "should destroy category" do
    category_deletable = categories(:deletable)
    assert_difference("Category.count", -1) do
      delete category_url(category_deletable)
    end

    assert_redirected_to categories_url
  end
end
