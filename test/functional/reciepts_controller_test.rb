require 'test_helper'

class RecieptsControllerTest < ActionController::TestCase
  setup do
    @reciept = reciepts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reciepts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reciept" do
    assert_difference('Reciept.count') do
      post :create, reciept: @reciept.attributes
    end

    assert_redirected_to reciept_path(assigns(:reciept))
  end

  test "should show reciept" do
    get :show, id: @reciept.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reciept.to_param
    assert_response :success
  end

  test "should update reciept" do
    put :update, id: @reciept.to_param, reciept: @reciept.attributes
    assert_redirected_to reciept_path(assigns(:reciept))
  end

  test "should destroy reciept" do
    assert_difference('Reciept.count', -1) do
      delete :destroy, id: @reciept.to_param
    end

    assert_redirected_to reciepts_path
  end
end
