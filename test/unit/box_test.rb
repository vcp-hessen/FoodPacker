require 'test_helper'

class BoxTest < ActiveSupport::TestCase
  
  test "should have meals" do
    box = boxes(:thursday_evening)
    
    assert box.meals.count == 2
  end
  
  test "should have group boxes" do
    box = boxes(:friday_morning)
    
    assert box.group_boxes.count == 1
  end

  test "should build a box for a group with all meals calculated" do
    box = boxes(:saturday_morning)
    group_box = box.build_calculated_box_for_group groups(:calc_group_15_people_1_2)
    
    assert_equal 1, box.group_boxes.length
    assert_equal 2, group_box.group_box_meals.length
    
  end
  
  test "should create a box for every group with all meals calculated" do
    box = boxes(:saturday_morning)
    group_boxes = box.create_calculated_boxes
    
    assert_equal 4, group_boxes.count
    assert_equal 6, GroupBoxMeal.count(:conditions => {:group_box_id => box.group_box_ids})
    
  end
end
