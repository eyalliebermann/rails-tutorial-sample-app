require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test 'wrong password flash displayed once and disappear' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session: {email:'e@ee.com', password:'qqqqqqq'}}
    assert_template 'sessions/new'
    assert_not flash.empty? #assert_select('.alert-danger')
    get root_path
    assert flash.empty? #assert_select '.alert-danger', 0
  end


end
