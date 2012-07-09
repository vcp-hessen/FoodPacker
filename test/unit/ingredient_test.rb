# coding: utf-8

require 'test_helper'

class IngredientTest < ActiveSupport::TestCase

  test "should output human readable quantity" do
    ingredient = ingredients(:three)
    
    assert_equal "1,5 kg", ingredient.human_readable_quantity
    
    ingredient.product.unit = "kg"
    ingredient.quantity = 1.5
    
    assert_equal "1,5 kg", ingredient.human_readable_quantity
    
    ingredient.product.unit = "kg"
    ingredient.quantity = 1.60003
    
    assert_equal "1,6 kg", ingredient.human_readable_quantity
    
    ingredient.product.unit = "l"
    ingredient.quantity = 0.020
    
    assert_equal "20 ml", ingredient.human_readable_quantity
    
    ingredient.product.unit = "ml"
    ingredient.quantity = 1004
    
    assert_equal "1 l", ingredient.human_readable_quantity
    
    ingredient.product.unit = "Stk."
    ingredient.quantity = 1
    
    assert_equal "1 Stk.", ingredient.human_readable_quantity
  end

  test "should output human readable plurals" do
    ingredient = ingredients(:three)
    
    ingredient.product.unit = "Glas"
    ingredient.quantity = 1
    
    assert_equal "1 Glas", ingredient.human_readable_quantity
    
    ingredient.product.unit = "Glas"
    ingredient.quantity = 2
    
    assert_equal "2 Gläser", ingredient.human_readable_quantity
    
    ingredient.product.unit = "Glas"
    ingredient.quantity = 0.020
    
    assert_equal "0,02 Gläser", ingredient.human_readable_quantity
    
    ingredient.product.unit = "Flasche"
    ingredient.quantity = 1
    
    assert_equal "1 Flasche", ingredient.human_readable_quantity
  end
end
