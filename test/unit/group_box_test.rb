require 'test_helper'

class GroupBoxTest < ActiveSupport::TestCase
  
  test "should have group box meals" do
    group_box = group_boxes(:one)
    
    assert group_box.group_box_meals.count == 2
  end

end
