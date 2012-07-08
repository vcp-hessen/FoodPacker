require 'test_helper'

class GroupMealTest < ActiveSupport::TestCase

  test "attributes may not be empty" do
    group_meal = GroupMeal.new
    group_meal.hunger_factor = nil
    group_meal.participants_count_deviation = nil
    
    assert group_meal.invalid?
    assert group_meal.errors[:meal_id].any?
    assert group_meal.errors[:group_id].any?
    assert group_meal.errors[:receipt_id].any?
    assert group_meal.errors[:hunger_factor].any?
    assert group_meal.errors[:participants_count_deviation].any?
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
  
  test "should calculate the meal participants count" do
    group_meal = group_meals(:supper_15_people_1_0)
    
    assert_equal 15, group_meal.meal_participants_count
    
    group_meal = group_meals(:supper_15_people_1_2)
    
    assert_equal 15, group_meal.meal_participants_count
    
    group_meal = group_meals(:supper_14_people_1_32)
    
    assert_equal 14, group_meal.meal_participants_count
    
    group_meal = group_meals(:supper_45_people_0_945)
    
    assert_equal 45, group_meal.meal_participants_count
  end
  
  test "should calculate the meal hunger factor" do
    group_meal = group_meals(:supper_15_people_1_0)
    
    assert_in_delta 1.0, group_meal.meal_hunger_factor, 0.0001
    
    group_meal = group_meals(:supper_15_people_1_2)
    
    assert_in_delta 1.2, group_meal.meal_hunger_factor, 0.0001
    
    group_meal = group_meals(:supper_14_people_1_32)
    
    assert_in_delta 1.32, group_meal.meal_hunger_factor, 0.0001
    
    group_meal = group_meals(:supper_45_people_0_945)
    
    assert_in_delta 0.945, group_meal.meal_hunger_factor, 0.0001
  end
  
end
