require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup

    @user = User.new( username: "Milo Bloom",
                      email: "milo.bloom@gmail.com",
                      password: "qwer1234")

  end

  test "User should be valid" do

    assert @user.valid?

  end

  # Username Tests
  test "Username should be present" do

    @user.username = ""
    assert_not @user.valid?

  end

  test "Username should be unique - case sensitive" do

    @user.save
    @user_duplicate = User.new( username: "Milo Bloom",
                                email: "test@gmail.com",
                                password: "qwer1234")
    assert_not @user_duplicate.valid?

  end

  test "Username should be unique - case insensitive" do

    @user.save
    @user_duplicate = User.new( username: "milo bloom",
                                email: "test@gmail.com",
                                password: "qwer1234")
    assert_not @user_duplicate.valid?

  end

  test "Username should not be too long" do

    @user.username = "abcdefghijklmnopqrstuvwxyz"
    assert_not @user.valid?

  end

  test "Username should not be too short" do

    @user.username = "abcdefg"
    assert_not @user.valid?

  end

  # Email Tests
  test "Email should be present" do

    @user.email = ""
    assert_not @user.valid?

  end

  test "Email should be unique - case sensitive" do

    @user.save
    @user_duplicate = User.new( username: "Cutter John",
                                email: "milo.bloom@gmail.com",
                                password: "qwer1234")
    assert_not @user_duplicate.valid?

  end

  test "Email should be unique - case insensitive" do

    @user.save
    @user_duplicate = User.new( username: "Cutter John",
                                email: "Milo.Bloom@gmail.com",
                                password: "qwer1234")
    assert_not @user_duplicate.valid?

  end

  test "Email should not be too long" do

    @user.email = "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901@gmail.com"
    assert_not @user.valid?

  end

  test "Email should be in email format" do

    @user.email = "Milo.Bloom.com"
    assert_not @user.valid?

  end

  # Password Tests
  test "Password should not be too long" do

    @user.password = "abcdefghijklmnopqrstuvwxyz"
    assert_not @user.valid?

  end

  test "Password should not be too short" do

    @user.password = "abcde"
    assert_not @user.valid?

  end

  # Admin Tests
  # None as of yet
  
end
