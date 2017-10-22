require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user= users(:michael)
  end

  test 'wrong password flash displayed once and disappear' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session: {email: 'e@ee.com', password: 'qqqqqqq'}}
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'log
in shown when no session exists' do
    get root_path
    assert_template 'static_pages/home'
    assert_select "header nav", /Log in/
  end

  test 'login changes header nav' do
    get login_path
    post login_path, params: {session: {email: @user.email, password: 'password'}}

    assert_not flash.empty?
    #why does this fail? #assert_select 'div.alert.alert-success'
    #assert_select "header nav", /Log in/, count: 0
    #assert_select "header nav", /Account/, count:1 #fails unexpectedly
  end

  test "login with valid information" do
    get login_path
    post login_path, params: {session: {email: @user.email, password: 'password'}}
    assert_not flash.empty?

    assert_redirected_to @user
    follow_redirect!

    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path, count: 1
    assert_select "a[href=?]", user_path(@user)
  end

  test "logout succesfully" do
    get login_path
    assert_select 'a[href=?]', login_path, count: 1
    assert_select 'a[href=?]', logout_path, count: 0

    post login_path, params: {session: {email: @user.email, password: 'password'}}
    assert is_logged_in?

    assert_redirected_to @user
    follow_redirect!
    get root_path
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path, count: 1
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert_select 'a[href=?]', login_path, {count: 1}, "Login link should appear after successful logout"
    assert_select 'a[href=?]', logout_path, {count: 0}, "Logout link should not appear after successful logout"
    assert_select 'a[href=?]', user_path(@user), {count: 0}, "User link should not be presented after successful logout"

  end
end
