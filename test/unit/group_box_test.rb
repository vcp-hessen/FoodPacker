require 'test_helper'

class GroupBoxTest < ActiveSupport::TestCase
  
  test "should have a group" do
    group_box = group_boxes(:one)
    
    assert group_box.group == groups(:hungry_group)
  end
  
  test "should have a box" do
    group_box = group_boxes(:one)
    
    assert group_box.box == boxes(:thursday_evening)
  end
  
  test "should have group box meals" do
    group_box = group_boxes(:one)
    
    assert group_box.group_box_meals.count == 2
  end

end
