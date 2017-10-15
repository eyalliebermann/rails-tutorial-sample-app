require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(name:"Example User", email:"user@example.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "Name should be present" do
    @user.name="           "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email ="                  "
    assert_not @user.valid?
  end

  test "name should not exceed 50 characters" do
    @user.name = 'a'*51
    assert_not @user.valid?
  end

  test "email should not exceed 255 characters" do
    at='@example.com'
    @user.email = "a" * (255-at.length+1) +at
    assert_not @user.valid?
  end

  test "verify tests are independent" do
    assert @user.valid?
  end
end
