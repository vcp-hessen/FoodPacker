require 'test_helper'

class IngredientsControllerTest < ActionController::TestCase
  setup do
    @ingredient = ingredients(:one)
  end

  test "should get index" do
    get :index, {}, {'user_id' => users(:foo).id}
    assert_response :success
    assert_not_nil assigns(:ingredients)
  end
  
  test "should not get index if not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should get new" do
    get :new, {}, {'user_id' => users(:foo).id}
    assert_response :success
  end
  
  test "should not get new if not logged in" do
    get :new
    assert_redirected_to login_url
  end

  test "should create ingredient" do
    assert_difference('Ingredient.count') do
      post :create, {ingredient: @ingredient.attributes}, {'user_id' => users(:foo).id}
    end

    assert_redirected_to ingredient_path(assigns(:ingredient))
  end
  
  test "should not create ingredient if not logged in" do
    assert_no_difference('Ingredient.count') do
      post :create, ingredient: @ingredient.attributes
    end

    assert_redirected_to login_url
  end

  test "should show ingredient" do
    get :show, {id: @ingredient.to_param}, {'user_id' => users(:foo).id}
    assert_response :success
  end
  
  test "should not show ingredient if not logged in" do
    get :show, id: @ingredient.to_param
    assert_redirected_to login_url
  end

  test "should get edit" do
    get :edit, {id: @ingredient.to_param}, {'user_id' => users(:foo).id}
    assert_response :success
  end
  
  test "should not get edit if not logged in" do
    get :edit, id: @ingredient.to_param
    assert_redirected_to login_url
  end

  test "should update ingredient" do
    put :update, {id: @ingredient.to_param, ingredient: @ingredient.attributes}, {'user_id' => users(:foo).id}
    assert_redirected_to ingredient_path(assigns(:ingredient))
  end
  
  test "should not update ingredient if not logged in" do
    put :update, id: @ingredient.to_param, ingredient: @ingredient.attributes
    assert_redirected_to login_url
  end

  test "should destroy ingredient" do
    assert_difference('Ingredient.count', -1) do
      delete :destroy, {id: @ingredient.to_param}, {'user_id' => users(:foo).id}
    end

    assert_redirected_to ingredients_path
  end
  
  test "should not destroy ingredient if not logged in" do
    assert_no_difference('Ingredient.count') do
      delete :destroy, id: @ingredient.to_param
    end

    assert_redirected_to login_path
  end
end
