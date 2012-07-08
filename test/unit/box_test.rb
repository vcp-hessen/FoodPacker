require 'test_helper'

class BoxTest < ActiveSupport::TestCase
  
  test "should have meals" do
    box = boxes(:thursday_evening)
    
    assert box.meals.count == 2
  end

end
