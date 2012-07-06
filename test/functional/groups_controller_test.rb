require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  setup do
    @group = groups(:group)
  end

  test "should get index" do
    get :index, {}, {'user_id' => users(:foo).to_param}
    assert_response :success
    assert_not_nil assigns(:groups)
  end

  test "should not get index if not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should get new" do
    get :new, {}, {'user_id' => users(:foo).to_param}
    assert_response :success
  end

  test "should create group" do
    otherGroup = Group.new(name: "Stamm sowieso",participants_count:24,hunger_factor:1.0)
    assert_difference('Group.count') do
      post :create, {group: otherGroup.attributes}, {'user_id' => users(:foo).to_param}
    end

    assert_redirected_to group_path(assigns(:group))
  end

  test "should show group" do
    get :show, {id: @group.to_param}, {'user_id' => users(:foo).to_param}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {id: @group.to_param}, {'user_id' => users(:foo).to_param}
    assert_response :success
  end

  test "should update group" do
    put :update, {id: @group.to_param, group: @group.attributes}, {'user_id' => users(:foo).to_param}
    assert_redirected_to group_path(assigns(:group))
  end

  test "should destroy group" do
    assert_difference('Group.count', -1) do
      delete :destroy, {id: @group.to_param}, {'user_id' => users(:foo).to_param}
    end

    assert_redirected_to groups_path
  end
end
