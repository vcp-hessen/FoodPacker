require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:zucker)
    @update = {
      name: "Milch",
      unit: "l"
    }
  end

  test "should get index" do
    get :index,{}, {'user_id' => users(:foo).id}
    assert_response :success
    assert_not_nil assigns(:products)
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

  test "should create product" do
    assert_difference('Product.count') do
      post :create, {product: @update}, {'user_id' => users(:foo).id}
    end

    assert_redirected_to product_path(assigns(:product))
  end
  
  test "should not create product if not logged in" do
    assert_no_difference('Product.count') do
      post :create, product: @update
    end

    assert_redirected_to login_url
  end

  test "should show product" do
    get :show, {id: @product.to_param}, {'user_id' => users(:foo).id}
    assert_response :success
  end
  
  test "should not show product if not logged in" do
    get :show, id: @product.to_param
    assert_redirected_to login_url
  end

  test "should get edit" do
    get :edit, {id: @product.to_param}, {'user_id' => users(:foo).id}
    assert_response :success
  end

  test "should not get edit if not logged in" do
    get :edit, id: @product.to_param
    assert_redirected_to login_url
  end

  test "should update product" do
    put :update, {id: @product.to_param, product: @update}, {'user_id' => users(:foo).id}
    assert_redirected_to product_path(assigns(:product))
  end
  
  test "should not update product if not logged in" do
    put :update, id: @product.to_param, product: @update
    assert_redirected_to login_url
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, {id: @product.to_param}, {'user_id' => users(:foo).id}
    end

    assert_redirected_to products_path
  end
  
  test "should not destroy product if not logged in" do
    assert_no_difference('Product.count') do
      delete :destroy, id: @product.to_param
    end

    assert_redirected_to login_url
  end
end
