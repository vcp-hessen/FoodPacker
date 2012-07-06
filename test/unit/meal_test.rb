require 'test_helper'

class MealTest < ActiveSupport::TestCase
  
  test "breakfast should have cereal receipt" do
    breakfast = meals(:breakfast)
    
    assert breakfast.receipts.include?(receipts(:cereals))
  end
  
  test "lunch should have soup and pork receipts" do
    breakfast = meals(:lunch)
    
    assert breakfast.receipts.include?(receipts(:soup))
    assert breakfast.receipts.include?(receipts(:pork))
  end
  
  test "lunch should have a group" do
    lunch = meals(:lunch)
    
    assert lunch.groups.include?(groups(:group))
  end
  
  test "receipts association is required" do
    fruhstuck = Meal.new(name: "Fruhstuck")
    
    assert fruhstuck.invalid?
    assert fruhstuck.errors[:receipts].any?
  end
  
  test "should associate all existing groups after creation" do
    fruhstuck = Meal.new(name: "Fruhstuck")
    fruhstuck.receipts << receipts(:cereals)
    fruhstuck.save!
    
    assert fruhstuck.groups.count == Group.count
  end
  
  test "should update existing group_meal associations after receipts have changed" do
    lunch = meals(:lunch)
    lunch.receipts.delete(receipts(:pork))
    lunch.save!
    
    group_meal = groups(:group).group_meals.find_by_meal_id(lunch.to_param)
    assert group_meal.receipt_id == receipts(:soup).id
  end
end
