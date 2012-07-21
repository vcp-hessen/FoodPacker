require 'test_helper'

class SpecialsControllerTest < ActionController::TestCase
  setup do
    @special = specials(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:specials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create special" do
    assert_difference('Special.count') do
      post :create, special: @special.attributes
    end

    assert_redirected_to special_path(assigns(:special))
  end

  test "should show special" do
    get :show, id: @special.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @special.to_param
    assert_response :success
  end

  test "should update special" do
    put :update, id: @special.to_param, special: @special.attributes
    assert_redirected_to special_path(assigns(:special))
  end

  test "should destroy special" do
    assert_difference('Special.count', -1) do
      delete :destroy, id: @special.to_param
    end

    assert_redirected_to specials_path
  end
end
