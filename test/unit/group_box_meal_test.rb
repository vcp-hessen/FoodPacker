require 'test_helper'

class GroupBoxMealTest < ActiveSupport::TestCase
  
  test "should have group box contents" do
    group_box_meal = group_box_meals(:one)
    
    assert group_box_meal.contents.count == 2
  end
    
end
