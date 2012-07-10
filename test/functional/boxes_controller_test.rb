require 'test_helper'

class BoxesControllerTest < ActionController::TestCase
  setup do
    @box = boxes(:thursday_evening)
  end

  test "should get index" do
    get :index, {}, {'user_id' => users(:foo).to_param}
    assert_response :success
    assert_not_nil assigns(:boxes)
  end
  
  test "should not get index if not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should get new" do
    get :new, {}, {'user_id' => users(:foo).to_param}
    assert_response :success
  end

  test "should create box" do
    assert_difference('Box.count') do
      post :create, {box: @box.attributes}, {'user_id' => users(:foo).to_param}
    end

    assert_redirected_to box_path(assigns(:box))
  end

  test "should show box" do
    get :show, {id: @box.to_param}, {'user_id' => users(:foo).to_param}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {id: @box.to_param}, {'user_id' => users(:foo).to_param}
    assert_response :success
  end

  test "should update box" do
    put :update, {id: @box.to_param, box: @box.attributes}, {'user_id' => users(:foo).to_param}
    assert_redirected_to box_path(assigns(:box))
  end

  test "should destroy box" do
    assert_difference('Box.count', -1) do
      delete :destroy, {id: @box.to_param}, {'user_id' => users(:foo).to_param}
    end

    assert_redirected_to boxes_path
  end
end
