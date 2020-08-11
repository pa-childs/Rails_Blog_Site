require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "get the new category form and create a category" do

    get "/categories/new"
    assert_response :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: "Ruby on Rails" } }
      assert_response :redirect

    end

    follow_redirect!
    assert_response :success
    assert_match "Ruby on Rails", response.body

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
