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

end
