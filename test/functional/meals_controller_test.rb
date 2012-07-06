require 'test_helper'

class MealsControllerTest < ActionController::TestCase
  setup do
    @meal = meals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:meals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create meal" do
    assert_difference('Meal.count') do
      post :create, meal: @meal.attributes
    end

    assert_redirected_to meal_path(assigns(:meal))
  end

  test "should show meal" do
    get :show, id: @meal.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @meal.to_param
    assert_response :success
  end

  test "should update meal" do
    put :update, id: @meal.to_param, meal: @meal.attributes
    assert_redirected_to meal_path(assigns(:meal))
  end

  test "should destroy meal" do
    assert_difference('Meal.count', -1) do
      delete :destroy, id: @meal.to_param
    end

    assert_redirected_to meals_path
  end
end
