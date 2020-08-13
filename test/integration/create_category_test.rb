require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create(username: "Admin User",
                              email:"admin.user@gmail.com",
                              password: "qwer1234",
                              admin: true)
    sign_in_as(@admin_user)
  end

  test "get the new category form and create a category" do

    get "/categories/new"
    assert_response :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: "New Category" } }
      assert_response :redirect

    end

    follow_redirect!
    assert_response :success
    assert_match "New Category", response.body

  end

  test "get the new category form and reject invalid category submission" do

    get "/categories/new"
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: " " } }

    end

    assert_match "The following error(s) prevented the category from being saved.", response.body
    assert_select 'div.alert'

  end

end
