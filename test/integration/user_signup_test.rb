require 'test_helper'

class UserGignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'do not create user on invalid signup information' do
    get signup_path
    assert_select 'form[action=?]', signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {user: {name:'', email:'e@invalid_domain', password:'foo', password_confirmation:'bar'}}
    end
  end

  test 'user creation results in data change' do
    get signup_path
    assert_difference 'User.count',1 do
      post users_path, params: {user:{name:'eyal', email:'valid@example.com', password:'foobar', password_confirmation:'foobar'}}
    end
    follow_redirect!
    assert_template 'users/show'
  end


  test 'show at least six errors on maximally erornous user' do
    get signup_path
    post users_path, params: {user: {name:'', email:'', password:'', password_confirmation:''}}
    assert_select "#error_explanation ul li"  do | element|
      puts
      # debug reason for failure # element.children.each {|msg| puts msg}
      assert_equal  6, element.children.count
    end
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?, "new user should be logged in upon signup"
  end
end
