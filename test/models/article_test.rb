require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  def setup

    @user = User.new( username: "Milo Bloom",
                      email: "milo.bloom@gmail.com",
                      password: "qwer1234")
    @user.save
    @article = Article.new(title: "Rails Unit Tests", description: "This is a test description.", user_id: "1")

  end

  test "Article should be valid" do

    assert @article.valid?

  end

  # Title Tests
  test "Title should be present" do

    @article.title = ""
    assert_not @article.valid?

  end

  test "Title should not be too long" do

    @article.title = "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901"
    assert_not @article.valid?

  end

  test "Title should not be too short" do

    @article.title = "12345"
    assert_not @article.valid?

  end

  # Description Tests
  test "Description should be present" do

    @article.description = ""
    assert_not @article.valid?

  end

  test "Description should not be too long" do

    @article.description = "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901"
    assert_not @article.valid?

  end

  test "Description should not be too short" do

    @article.description = "123456789"
    assert_not @article.valid?

  end

  # User ID Tests
  test "User ID should be present" do

    @article.user_id = ""
    assert_not @article.valid?

  end

end
