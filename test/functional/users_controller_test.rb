require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  test "should get new" do
    get :new, {}, {'user_id' => users(:foo).id}
    assert_template 'new'
  end
  
  test "should not get new if not logged in" do
    get :new
    assert_redirected_to login_url
  end

  def test_create_invalid
    User.any_instance.stubs(:valid?).returns(false)
    post :create, {}, {'user_id' => users(:foo).id}
    assert_template 'new'
  end

  def test_create_valid
    User.any_instance.stubs(:valid?).returns(true)
    post :create, {}, {'user_id' => users(:foo).id}
    assert_redirected_to root_url
    assert_equal assigns['user'].id, session['user_id']
  end
  
  def test_create_valid_without_user
    User.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to login_url
    assert_nil session['user_id']
  end

  def test_edit_without_user
    session[:user_id] = nil
    get :edit, :id => "ignored"
    assert_redirected_to login_url
  end

  def test_edit
    @controller.stubs(:current_user).returns(User.first)
    get :edit, :id => "ignored"
    assert_template 'edit'
  end

  def test_update_without_user
    session[:user_id] = nil
    put :update, :id => "ignored"
    assert_redirected_to login_url
  end

  def test_update_invalid
    @controller.stubs(:current_user).returns(User.first)
    User.any_instance.stubs(:valid?).returns(false)
    put :update, :id => "ignored"
    assert_template 'edit'
  end

  def test_update_valid
    @controller.stubs(:current_user).returns(User.first)
    User.any_instance.stubs(:valid?).returns(true)
    put :update, :id => "ignored"
    assert_redirected_to root_url
  end
end
