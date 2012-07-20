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
  
  test "should calculate a quantity given people count" do
    ingredient = ingredients(:three)
    
    assert_in_delta 750, ingredient.calculate_quantity(for_people:5)
  end
  
  test "should calculate a quantity given people count and hunger_factor > 1" do
    ingredient = ingredients(:three)
    
    assert_in_delta 825, ingredient.calculate_quantity(for_people:5, hunger_factor:1.1)
  end
  
  test "should calculate a quantity given people count and hunger_factor < 1" do
    ingredient = ingredients(:three)
    
    assert_in_delta 675, ingredient.calculate_quantity(for_people:5, hunger_factor:0.9), 0.001
  end
  
  test "should calculate fixed quantity ingredients" do
    ingredient = ingredients(:fixed_quantity)
    
    assert_in_delta 2.4, ingredient.calculate_quantity(for_people:24, hunger_factor:1.6), 0.001
  end
  
  test "should calculate not hunger relevant ingredients with factor > 1" do
    ingredient = ingredients(:not_hunger_relevant)
    
    assert_in_delta 18, ingredient.calculate_quantity(for_people:35, hunger_factor:1.6), 0.001
  end
  
  test "should calculate not hunger relevant ingredients with factor < 1" do
    ingredient = ingredients(:not_hunger_relevant)
    
    assert_in_delta 15, ingredient.calculate_quantity(for_people:35, hunger_factor:0.8), 0.001
  end
  
  test "should round on products rounding amount" do
    ingredient = ingredients(:rounding_on_500)
    
    assert_in_delta 1500, ingredient.calculate_quantity(for_people:40), 0.001
  end
  
  test "should round up on 0.3 of rounding amount" do
    ingredient = ingredients(:rounding_on_500)
    
    assert_in_delta 2000, ingredient.calculate_quantity(for_people:44), 0.001
  end
  
  test "should round at least one time rounding amount" do
    ingredient = ingredients(:rounding_on_500)
    
    assert_in_delta 500, ingredient.calculate_quantity(for_people:10), 0.001
  end
  
end
