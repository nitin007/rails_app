require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { :username => "nitin", :password => "nitin", :password_confirmation => "nitin" }
    end

    assert_redirected_to posts_path
  end
  
  test "should login user" do
    post :create, user: { :username => "nitin", :password => "nitin", :password_confirmation => "nitin" }
  	post :login, :username => "nitin", :password => "nitin"
  	assert_redirected_to posts_path
  end  
end
