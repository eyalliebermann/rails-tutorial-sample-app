require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(name:"Example User", email:"user@example.com", password:"foobar", password_confirmation:"foobar")
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

  test "valid email addresses shold be allowed" do
  valid_addresses = %w[ name@domain.com dotted.name@d.co a-b@c.il AbC@g.com.co who@gmail.com very-long.23@com.es]
  valid_addresses.each do |address|
    @user.email =address
    assert @user.valid?, "#{address.inspect} should be valid"
    end
  end

  test "email validation reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]

    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address} should be invalid"
    end
  end

  test "duplicate email should be rejected" do
    duplicant = User.new(name:"something", email:@user.email)
    @user.save
    assert_not duplicant.valid?
  end

  test "duplicate email should be rejected regardless of case" do
    dup = @user.dup
    dup.email.upcase!
    @user.save
    assert_not dup.valid?
  end

  test "email is save as lowercase" do
    @user.email.upcase!
    @user.save
    assert_equal @user.email.downcase, @user.reload.email, "email is ecpecterd to be lowercase only after being saved"
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "verify tests are independent" do
    assert @user.valid?
  end
end
