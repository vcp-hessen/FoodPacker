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

end
