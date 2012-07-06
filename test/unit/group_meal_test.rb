require 'test_helper'

class GroupMealTest < ActiveSupport::TestCase

  test "attributes may not be empty" do
    product = GroupMeal.new
    
    assert product.invalid?
    assert product.errors[:meal_id].any?
    assert product.errors[:group_id].any?
    assert product.errors[:receipt_id].any?
    assert product.errors[:hunger_factor].any?
    assert product.errors[:participants_count_deviation].any?
  end

  test "participants_count_deviation must be an integer" do
    group_meal = group_meals(:one)
    group_meal.participants_count_deviation = "foo"
    
    assert group_meal.invalid?
    assert group_meal.errors[:participants_count_deviation].any?
  end
  
  test "participants_count_deviation can be negative" do
    group_meal = group_meals(:one)
    group_meal.participants_count_deviation = -1
    
    assert group_meal.valid?
    assert group_meal.errors[:participants_count_deviation].empty?
  end
  
  test "hunger_factor must be a number" do
    group_meal = group_meals(:one)
    group_meal.hunger_factor = "foo"
    
    assert group_meal.invalid?
    assert group_meal.errors[:hunger_factor].any?
  end
  
  test "hunger_factor must be between 0.4 and 1.6" do
    group_meal = group_meals(:one)
    group_meal.hunger_factor = 0.0
    
    assert group_meal.invalid?
    assert group_meal.errors[:hunger_factor].any?
    
    group_meal.hunger_factor = -0.1
    
    assert group_meal.invalid?
    assert group_meal.errors[:hunger_factor].any?
    
    group_meal.hunger_factor = 0.4
    
    assert group_meal.valid?
    assert group_meal.errors[:hunger_factor].empty?
    
    group_meal.hunger_factor = 1.0
    
    assert group_meal.valid?
    assert group_meal.errors[:hunger_factor].empty?
    
    group_meal.hunger_factor = 1.6
    
    assert group_meal.valid?
    assert group_meal.errors[:hunger_factor].empty?
    
    group_meal.hunger_factor = 1.62
    
    assert group_meal.invalid?
    assert group_meal.errors[:hunger_factor].any?
  end
end
