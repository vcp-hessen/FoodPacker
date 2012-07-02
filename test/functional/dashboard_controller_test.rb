require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  
  setup do
    session[:user_id] = users(:foo).id
  end
  
  test "should get index" do
    get :index
    assert_response :success
  end
  
  test "should not get index without logged in user" do
    session[:user_id] = nil
    get :index
    assert_redirected_to login_url
  end

end
