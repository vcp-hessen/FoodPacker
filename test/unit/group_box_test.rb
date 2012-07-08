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

  test "should raise when initialized without box_id" do
    exception = assert_raise RuntimeError do
      GroupBox.new(group_id:1)
    end
    
    assert_equal "initialized group box without box_id", exception.message
  end
  
  test "should raise when initialized without group_id" do
    exception = assert_raise RuntimeError do
      GroupBox.new(box_id:1)
    end
    
    assert_equal "initialized group box without group_id", exception.message
  end
  
end
