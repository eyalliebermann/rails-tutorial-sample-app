require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @title_text = "RoR Tutorial Sample App"
  end
  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "Home | #{@title_text}"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title", "Help | #{@title_text}"
  end
  
  test "should get about controller response" do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "About | #{@title_text}"
  end

  test "should get contact" do
    get static_pages_contact_url
    assert_response :success
    assert_select "title","Contact | #{@title_text}"
  end
end
