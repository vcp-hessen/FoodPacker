require 'test_helper'

class MealsControllerTest < ActionController::TestCase
  setup do
    @meal = meals(:breakfast)
  end

  test "should get index" do
    get :index, {}, {'user_id' => users(:foo).to_param}
    assert_response :success
    assert_not_nil assigns(:meals)
  end
  
  test "should get index sorted by time" do
    
    late_breakfast = meals(:breakfast)
    late_breakfast.time = meals(:lunch).time.advance(hours: 1)
    late_breakfast.save!
    
    get :index, {}, {'user_id' => users(:foo).to_param}
    assert_response :success
    assert assigns(:meals).first == meals(:lunch)
    assert assigns(:meals).last == meals(:supper)
  end
  
  test "should not get index if not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should get new" do
    get :new, {}, {'user_id' => users(:foo).to_param}
    assert_response :success
  end

  test "should create meal" do
    meal_attributes = @meal.attributes
    meal_attributes[:receipt_ids] = [1]
    assert_difference('Meal.count') do
      post :create, {meal: meal_attributes}, {'user_id' => users(:foo).to_param}
    end

    assert_redirected_to meal_path(assigns(:meal))
  end

  test "should show meal" do
    get :show, {id: @meal.to_param}, {'user_id' => users(:foo).to_param}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {id: @meal.to_param}, {'user_id' => users(:foo).to_param}
    assert_response :success
  end

  test "should update meal" do
    put :update, {id: @meal.to_param, meal: @meal.attributes}, {'user_id' => users(:foo).to_param}
    assert_redirected_to meal_path(assigns(:meal))
  end

  test "should destroy meal" do
    assert_difference('Meal.count', -1) do
      delete :destroy, {id: @meal.to_param}, {'user_id' => users(:foo).to_param}
    end

    assert_redirected_to meals_path
  end
end
