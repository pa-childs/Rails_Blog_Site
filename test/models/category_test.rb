require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup

    @category = Category.new(name: "Rails")

  end

  test "Category should be valid" do

    assert @category.valid?

  end

  test "Category name should be present" do

    @category.name = ""
    assert_not @category.valid?

  end

  test "Category name should be unique" do

    @category.save
    @category_duplicate = Category.new(name: "Rails")
    assert_not @category_duplicate.valid?

  end

  test "Category name should not be too long" do

    @category.name = "abcdefghijklmnopqrstuvwxyz"
    assert_not @category.valid?

  end

  test "Category name should not be too short" do

    @category.name = "ab"
    assert_not @category.valid?

  end

end
