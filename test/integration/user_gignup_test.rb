require 'test_helper'

class UserGignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'do not create user when errornous' do
    get signup_path
    assert_no_difference 'User.count' do
    post users_path, params: {user: {name:'', email:'e@invalid_domain', password:'foo', password_confirmation:'bar'}}
      end
  end
end
