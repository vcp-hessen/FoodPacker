require 'test_helper'

class ReceiptsControllerTest < ActionController::TestCase
  setup do
    @receipt = receipts(:soup)
  end

  test "should get index" do
    get :index, {}, {'user_id' => users(:foo).id}
    assert_response :success
    assert_not_nil assigns(:receipts)
  end
  
  test "should not get index if not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should get new" do
    get :new,{}, {'user_id' => users(:foo).id}
    assert_response :success
  end
  
  test "should not get new if not logged in" do
    get :new
    assert_redirected_to login_url
  end

  test "should create receipt" do
    assert_difference('Receipt.count') do
      post :create, {receipt: @receipt.attributes.except('id', 'created_at', 'updated_at')}, {'user_id' => users(:foo).id}
    end

    assert_redirected_to receipt_path(assigns(:receipt))
  end
  
  test "should not create receipt if not logged in" do
    assert_no_difference('Receipt.count') do
      post :create, receipt: @receipt.attributes.except('id', 'created_at', 'updated_at')
    end

    assert_redirected_to login_url
  end

  test "should show receipt" do
    get :show, {id: @receipt.to_param}, {'user_id' => users(:foo).id}
    assert_response :success
  end
  
  test "should not show receipt if not logged in" do
    get :show, id: @receipt.to_param
    assert_redirected_to login_url
  end

  test "should get edit" do
    get :edit, {id: @receipt.to_param}, {'user_id' => users(:foo).id}
    assert_response :success
  end
  
  test "should not get edit if not logged in" do
    get :edit, id: @receipt.to_param
    assert_redirected_to login_url
  end

  test "should update receipt" do
    put :update, {id: @receipt.to_param, receipt: @receipt.attributes.except('id','created_at','updated_at')}, {'user_id' => users(:foo).id}
    assert_redirected_to receipt_path(assigns(:receipt))
  end
  
  test "should add ingredients through nested forms" do
    assert_difference('@receipt.ingredients.count', 1) do
      put :update, {id: @receipt.to_param, receipt: {"ingredients_attributes" => {"new_123" => {'quantity' => 2, 'product_id' => 1}}}}, {'user_id' => users(:foo).id}
    end
    assert_redirected_to receipt_path(assigns(:receipt))
  end
  
  test "should delete ingredients through nesting" do
    ingredient = ingredients(:two)
    @receipt.ingredients << ingredient
    assert_difference('@receipt.ingredients.count', -1) do
      put :update, {id: @receipt.to_param, receipt: {"ingredients_attributes" => {"0" => {'id' => ingredient.id, '_destroy' => 1}}}}, {'user_id' => users(:foo).id}
    end
    assert_redirected_to receipt_path(assigns(:receipt))
  end
  
  test "should not update receipt if not logged in" do
    put :update, id: @receipt.to_param, receipt: @receipt.attributes.except('id', 'created_at', 'updated_at')
    assert_redirected_to login_url
  end

  test "should destroy receipt" do
    assert_difference('Receipt.count', -1) do
      @receipt.meals.clear
      delete :destroy, {id: @receipt.to_param}, {'user_id' => users(:foo).id}
    end

    assert_redirected_to receipts_path
  end
  
  test "should not destroy receipt if not logged in" do
    assert_no_difference('Receipt.count') do
      delete :destroy, id: @receipt.to_param
    end

    assert_redirected_to login_path
  end
end
