require 'test_helper'

class GroupBoxMealTest < ActiveSupport::TestCase

  test "should have a group box" do
    group_box_meal = group_box_meals(:one)
    
    assert group_box_meal.group_box == group_boxes(:one)
  end

  test "should have a meal" do
    group_box_meal = group_box_meals(:two)
    
    assert group_box_meal.meal == meals(:supper)
  end

  test "should have group box contents" do
    group_box_meal = group_box_meals(:one)
    
    assert group_box_meal.contents.count == 2
  end

  test "should have a group" do
    group_box_meal = group_box_meals(:one)
    
    assert_equal groups(:hungry_group), group_box_meal.group
  end
  
  test "should raise when initialized without meal_id" do
    exception = assert_raise RuntimeError do
      GroupBoxMeal.new(group_box_id:1)
    end
    
    assert_equal "initialized group box meal without meal_id", exception.message
  end
  
  test "should build contents from ingredients, count and hunger_factor" do
    group_box_meal = group_box_meals(:two)
    receipt = receipts(:pork)
    group_box_meal.build_contents_from_ingredients_hunger_factor receipt.ingredients, 1.0
    
    assert_equal 2, group_box_meal.contents.length
  end
  
  test "should correctly calculate contents from pork hunger_factor 1.0" do
    group_box_meal = group_box_meals(:two)
    receipt = receipts(:pork)
    
    group_box_meal.participants_count = 10
    group_box_meal.build_contents_from_ingredients_hunger_factor receipt.ingredients, 1.0
    
    group_box_meal.contents.each do |content|
      assert_in_delta 1500.0, content.quantity, 0.001 if content.name == 'meat'
      assert_in_delta 1.0, content.quantity, 0.001 if content.name == 'salt'
    end
  end

  test "should correctly calculate contents from pork hunger_factor 1.1" do
    group_box_meal = group_box_meals(:two)
    receipt = receipts(:pork)
    
    group_box_meal.participants_count = 13
    group_box_meal.build_contents_from_ingredients_hunger_factor receipt.ingredients, 1.1
    
    group_box_meal.contents.each do |content|
      assert_in_delta 2145.0, content.quantity, 0.001 if content.name == 'meat'
      assert_in_delta 1.43, content.quantity, 0.001 if content.name == 'salt'
    end
  end
end
